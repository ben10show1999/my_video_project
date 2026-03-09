/**
 * Ghost Proxy Service Worker
 * ✅ Task 7: Zero-RAM Chunked Streaming to bypass Safari 4GB Blob limit
 */
self.addEventListener('install', event => self.skipWaiting());
self.addEventListener('activate', event => event.waitUntil(self.clients.claim()));

self.addEventListener('fetch', event => {
    const url = new URL(event.request.url);
    if (url.pathname === '/stream' && url.searchParams.has('url')) {
        const realUrl = decodeURIComponent(url.searchParams.get('url'));
        event.respondWith(
            fetch(realUrl, { headers: event.request.headers })
            .then(response => {
                // Stream directly to the browser pipe, bypassing memory Blobs
                return new Response(response.body, {
                    status: response.status,
                    statusText: response.statusText,
                    headers: response.headers
                });
            })
            .catch(err => new Response('Stream Proxy Error', { status: 500 }))
        );
    }
});
