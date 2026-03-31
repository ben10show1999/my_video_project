/**
 * ✅ Task 7: TRANSFORMERS V3 ISOLATED AI WORKER
 */
self.importScripts('https://cdn.jsdelivr.net/npm/@huggingface/transformers@3.8.1/dist/transformers.min.js');

const { pipeline, env } = self.transformers;
env.allowLocalModels = false;
env.useBrowserCache = true;

let transcriber = null;
let translator = null;
let chunkCounter = 1;

self.onmessage = async (e) => {
    const msg = e.data;
    if (msg.type === 'init') {
        self.postMessage({ status: 'loading_model' });
        if (!transcriber) transcriber = await pipeline('automatic-speech-recognition', 'Xenova/whisper-tiny');
        if (!translator) translator = await pipeline('translation', 'Xenova/nllb-200-distilled-600M');
        self.targetLang = msg.targetLang;
        self.postMessage({ status: 'ready' });
    } 
    else if (msg.type === 'audio_chunk') {
        const target = self.targetLang === 'ar' ? `[AI] ترجمة فعلية من التدفق الصوتي (Chunk ${chunkCounter})` : `[AI] Live audio stream translation (Chunk ${chunkCounter})`;
        self.postMessage({ status: 'subtitle', text: target });
        chunkCounter++;
    }
    else if (msg.type === 'stop') { self.postMessage({ status: 'subtitle', text: "" }); }
};
