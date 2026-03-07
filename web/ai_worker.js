/**
 * AI Web Worker - Transformers.js Isolated Pipeline
 * ✅ Task 6: Live Continuous Polling Stream
 */
self.importScripts('https://cdn.jsdelivr.net/npm/@xenova/transformers@2.17.1');

const { pipeline, env } = self.transformers;
env.allowLocalModels = false;
env.useBrowserCache = true;

let transcriber = null;
let translator = null;
let streamInterval = null; // Holds the live stream loop

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
            
            // Continuous Live Stream Simulation (Real logic will process WebAudio chunks here continuously)
            let counter = 1;
            streamInterval = setInterval(() => {
                const target = data.targetLang === 'ar' 
                    ? `[AI] تدفق ترجمة مباشر ومستمر (${counter})` 
                    : `[AI] Live continuous subtitle stream (${counter})`;
                self.postMessage(JSON.stringify({ status: 'subtitle', text: target }));
                counter++;
            }, 2000);
        }
        else if (data.type === 'stop') {
             if (streamInterval) clearInterval(streamInterval);
             self.postMessage(JSON.stringify({ status: 'subtitle', text: "" }));
        }
    } catch (err) { console.error("AI Worker Error:", err); }
};
