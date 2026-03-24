self.addEventListener('fetch', event => {
  const url = new URL(event.request.url);
  if (url.pathname.includes('/stealth-stream/')) {
    const realTarget = url.searchParams.get('target');
    if (realTarget) {
      event.respondWith(fetch(realTarget, { headers: event.request.headers, mode: 'cors', credentials: 'omit' }).then(response => {
          return new Response(response.body, { status: response.status, statusText: response.statusText, headers: response.headers });
      }));
    }
  }
});
