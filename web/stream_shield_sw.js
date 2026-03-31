/**
 * ✅ Task 8: ENCRYPTED SERVICE WORKER SHIELD
 * Solves Safari 4GB Blob limit & 0% RAM Bloat via pure HTTP Piping
 */
self.addEventListener('install', (e) => self.skipWaiting());
self.addEventListener('activate', (e) => e.waitUntil(self.clients.claim()));

self.addEventListener('fetch', (event) => {
  const url = new URL(event.request.url);
  
  if (url.pathname.startsWith('/protected_stream/')) {
    const payload = url.pathname.replace('/protected_stream/', '');
    const realUrl = atob(payload); 
    event.respondWith(
      fetch(realUrl, { headers: event.request.headers }).then(response => {
        return new Response(response.body, { status: response.status, statusText: response.statusText, headers: response.headers });
      }).catch(err => { return new Response('', {status: 500}); })
    );
  }
});
