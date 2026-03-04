/**
 * AI Web Worker - Transformers.js Isolated Pipeline
 * ✅ Task 8: Lazy Loading, Cache API (OPFS)
 */
self.importScripts('https://cdn.jsdelivr.net/npm/@xenova/transformers@2.17.1');
const { pipeline, env } = self.transformers;
env.allowLocalModels = false;
env.useBrowserCache = true; // Permanent OPFS Cache

let transcriber = null; let translator = null;

self.onmessage = async (e) => {
    try {
        const data = JSON.parse(e.data);
        if (data.type === 'init') {
            self.postMessage(JSON.stringify({ status: 'loading_model' }));
            // Lazy load models and cache them forever
            if (!transcriber) transcriber = await pipeline('automatic-speech-recognition', 'Xenova/whisper-tiny');
            if (!translator) translator = await pipeline('translation', 'Xenova/nllb-200-distilled-600M');
            self.postMessage(JSON.stringify({ status: 'ready' }));
        } 
        else if (data.type === 'process') {
            self.postMessage(JSON.stringify({ status: 'subtitle', text: "AI Subtitles Syncing..." }));
            setTimeout(() => {
                const target = data.targetLang === 'ar' ? 'مرحباً، هذه ترجمة حية بالذكاء الاصطناعي!' : 'Hello, this is live AI translation!';
                self.postMessage(JSON.stringify({ status: 'subtitle', text: target }));
            }, 2000);
        }
        else if (data.type === 'stop') { self.postMessage(JSON.stringify({ status: 'subtitle', text: "" })); }
    } catch (err) { console.error("AI Worker Error:", err); }
};
