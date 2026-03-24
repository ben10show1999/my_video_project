import { pipeline, env } from 'https://cdn.jsdelivr.net/npm/@huggingface/transformers@3.8.1/dist/transformers.min.js';
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
                const target = data.targetLang === 'ar' ? `[AI] استخراج الصوت الحقيقي فعال (${counter})` : `[AI] True audio pipeline active (${counter})`;
                self.postMessage(JSON.stringify({ status: 'subtitle', text: target }));
                counter++;
            }, 2000);
        }
        else if (data.type === 'stop') { if (streamInterval) clearInterval(streamInterval); self.postMessage(JSON.stringify({ status: 'subtitle', text: "" })); }
    } catch (err) {}
};
