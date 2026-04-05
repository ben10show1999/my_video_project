/*! coi-serviceworker v0.1.6 - The Safe Multi-Threading Matrix */
if (typeof window === "undefined") {
    self.addEventListener("install", () => self.skipWaiting());
    self.addEventListener("activate", (e) => e.waitUntil(self.clients.claim()));
    self.addEventListener("fetch", function (e) {
        if (e.request.cache === "only-if-cached" && e.request.mode !== "same-origin") {
            return;
        }
        e.respondWith(
            fetch(e.request).then((r) => {
                if (r.status === 0) { return r; }
                const headers = new Headers(r.headers);
                // The Magic Headers for Wasm Multi-threading
                headers.set("Cross-Origin-Embedder-Policy", "require-corp");
                headers.set("Cross-Origin-Opener-Policy", "same-origin");
                return new Response(r.body, {
                    status: r.status,
                    statusText: r.statusText,
                    headers,
                });
            }).catch((e) => console.error(e))
        );
    });
} else {
    (() => {
        const e = window.document.currentScript;
        if (e) {
            console.log("🛠️ Injecting COI ServiceWorker for Hardware Multi-threading...");
            window.navigator.serviceWorker.register(e.src).then((e) => {
                e.addEventListener("updatefound", () => {
                    console.log("♻️ Reloading to activate COI Headers...");
                    window.location.reload();
                });
                if (e.active && !window.crossOriginIsolated) {
                    console.log("♻️ Reloading to activate COI Headers...");
                    window.location.reload();
                }
            });
        }
    })();
}
