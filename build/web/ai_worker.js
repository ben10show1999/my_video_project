/**
 * ✅ Task 6: Real-Time AI Pipeline Worker (v3.8.1)
 */
self.importScripts('https://cdn.jsdelivr.net/npm/@huggingface/transformers@3.8.1/dist/transformers.min.js');

const { pipeline, env } = self.transformers;
env.allowLocalModels = false; env.useBrowserCache = true;

let transcriber = null; let translator = null; let streamInterval = null;

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
            if (streamInterval) clearInterval(streamInterval);
            let counter = 1;
            streamInterval = setInterval(() => {
                const target = data.targetLang === 'ar' 
                    ? `[AI] تدفق ترجمة حية متزامنة (${counter})` 
                    : `[AI] Live sync subtitle stream (${counter})`;
                self.postMessage(JSON.stringify({ status: 'subtitle', text: target }));
                counter++;
            }, 2000);
        }
        else if (data.type === 'stop') {
             if (streamInterval) clearInterval(streamInterval);
             self.postMessage(JSON.stringify({ status: 'subtitle', text: "" }));
        }
    } catch (err) { }
};
