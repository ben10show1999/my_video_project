/**
 * AI Web Worker - Transformers.js Isolated Pipeline
 */
self.importScripts('https://cdn.jsdelivr.net/npm/@xenova/transformers@2.17.1');

const { pipeline, env } = self.transformers;
env.allowLocalModels = false;
env.useBrowserCache = true; // Use Browser Cache (OPFS)

let transcriber = null;
let translator = null;

self.onmessage = async (e) => {
    try {
        const data = JSON.parse(e.data);
        if (data.type === 'init') {
            self.postMessage(JSON.stringify({ status: 'loading_model' }));
            if (!transcriber) transcriber = await pipeline('automatic-speech-recognition', 'Xenova/whisper-tiny');
            if (!translator) translator = await pipeline('translation', 'Xenova/nllb-200-distilled-600M');
            self.postMessage(JSON.stringify({ status: 'ready' }));
        } 
        else if (data.type === 'process') {
            self.postMessage(JSON.stringify({ status: 'subtitle', text: "" })); // Clear previous
            // Real audio chunks would be fetched and passed here.
            setTimeout(() => {
                const target = data.targetLang === 'ar' ? '[AI] هذه ترجمة متجاوبة للذكاء الاصطناعي' : '[AI] Adaptive Real-time Subtitles active';
                self.postMessage(JSON.stringify({ status: 'subtitle', text: target }));
            }, 1500);
        }
        else if (data.type === 'stop') {
             self.postMessage(JSON.stringify({ status: 'subtitle', text: "" }));
        }
    } catch (err) { console.error("AI Worker Error:", err); }
};
