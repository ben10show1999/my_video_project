self.importScripts('https://cdn.jsdelivr.net/npm/@huggingface/transformers@3.8.1/dist/transformers.min.js');

const { pipeline, env } = self.transformers;
env.allowLocalModels = false;
env.useBrowserCache = true;

let transcriber = null;
let translator = null;
let isProcessing = false; 
let audioBuffer = [];

self.onmessage = async (e) => {
    try {
        const data = e.data;
        if (data.type === 'init') {
            self.postMessage(JSON.stringify({ status: 'loading_model' }));
            // Lazy load models from HuggingFace CDN
            if (!transcriber) transcriber = await pipeline('automatic-speech-recognition', 'Xenova/whisper-tiny');
            if (!translator) translator = await pipeline('translation', 'Xenova/nllb-200-distilled-600M');
            self.postMessage(JSON.stringify({ status: 'ready' }));
        } 
        else if (data.type === 'audio_chunk') {
            // Collect chunks. Process every ~3 seconds (48000 samples at 16kHz)
            const floatData = Object.values(data.data); // convert dict/array back to simple array
            audioBuffer.push(...floatData);
            
            if (audioBuffer.length >= 48000 && !isProcessing && transcriber && translator) {
                isProcessing = true;
                const input = new Float32Array(audioBuffer);
                audioBuffer = []; // reset for next batch
                
                try {
                    const result = await transcriber(input);
                    let text = result.text;
                    
                    if (data.targetLang && data.targetLang !== 'en') {
                        const targetCode = data.targetLang === 'ar' ? 'arb_Arab' : (data.targetLang === 'es' ? 'spa_Latn' : 'fra_Latn');
                        const trans = await translator(text, { src_lang: 'eng_Latn', tgt_lang: targetCode });
                        text = trans[0].translation_text;
                    }
                    self.postMessage(JSON.stringify({ status: 'subtitle', text: text }));
                } catch(err) { console.error("Transformers Exec Error", err); }
                isProcessing = false;
            }
        }
        else if (data.type === 'stop') {
             audioBuffer = [];
             self.postMessage(JSON.stringify({ status: 'subtitle', text: "" }));
        }
    } catch (err) { console.error("AI Worker Initial Error:", err); }
};
