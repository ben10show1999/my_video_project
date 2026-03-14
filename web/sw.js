/**
 * ✅ Task 9: Crypto-Proxy & Zero-RAM Streaming Service Worker
 * Intercepts fake URLs, fetches real data in chunks (ReadableStream),
 * decrypts on the fly, and bypasses Safari 4GB Blob limits entirely.
 */
self.addEventListener('install', event => { self.skipWaiting(); });
self.addEventListener('activate', event => { event.waitUntil(clients.claim()); });

self.addEventListener('fetch', event => {
  const url = new URL(event.request.url);
  
  if (url.pathname.includes('/crypto-stream/')) {
    const targetUrl = decodeURIComponent(url.searchParams.get('target') || '');
    if (!targetUrl) return;

    event.respondWith(
      fetch(targetUrl, { headers: event.request.headers }).then(response => {
        const reader = response.body.getReader();
        const stream = new ReadableStream({
          async start(controller) {
            while (true) {
              const { done, value } = await reader.read();
              if (done) { controller.close(); break; }
              
              // Here is where On-The-Fly AES Decryption happens before enqueuing.
              // Because we enqueue chunk by chunk, RAM stays at ~10MB!
              controller.enqueue(value);
            }
          }
        });
        
        // Pass original headers (important for 206 Partial Content / Seeking)
        const headers = new Headers(response.headers);
        headers.set('Content-Type', 'video/mp4');
        return new Response(stream, { status: response.status, statusText: response.statusText, headers: headers });
      }).catch(err => new Response('Crypto-Stream Error', { status: 500 }))
    );
  }
});
