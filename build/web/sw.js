/**
 * Ghost Proxy Service Worker (Fixed)
 * Safe Chunked Streaming without triggering UI Reloads
 */
self.addEventListener('install', event => self.skipWaiting());
self.addEventListener('activate', event => event.waitUntil(self.clients.claim()));

self.addEventListener('fetch', event => {
    const url = new URL(event.request.url);
    // Strict scoping: ONLY intercept requests meant for our DRM proxy
    if (url.pathname.includes('/local-app-proxy/stream') || (url.pathname === '/stream' && url.searchParams.has('url'))) {
        const realUrl = decodeURIComponent(url.searchParams.get('url'));
        event.respondWith(
            fetch(realUrl, { headers: event.request.headers })
            .then(response => {
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
