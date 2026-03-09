/**
 * Audio Bridge for Flutter <-> Transformers.js
 * ✅ Task 6: Extracts Float32Array chunks from video and pipes to Web Worker
 */
let aiWorker = null;
let audioCtx = null;
let scriptNode = null;

window.startAudioPipeline = function(videoUrl, targetLang) {
    if (!aiWorker) {
        aiWorker = new Worker('ai_worker.js');
        aiWorker.onmessage = (e) => {
            // Forward to Flutter Interop
            window.dispatchEvent(new CustomEvent('ai_bridge_msg', { detail: e.data }));
        };
        aiWorker.postMessage(JSON.stringify({ type: 'init' }));
    }

    const video = document.querySelector('video');
    if (!video) return;

    if (!audioCtx) audioCtx = new (window.AudioContext || window.webkitAudioContext)({ sampleRate: 16000 });
    
    // Resume context if suspended
    if (audioCtx.state === 'suspended') audioCtx.resume();

    try {
        if(!video.dataset.aiRouted) {
            const source = audioCtx.createMediaElementSource(video);
            scriptNode = audioCtx.createScriptProcessor(4096, 1, 1);
            source.connect(scriptNode);
            scriptNode.connect(audioCtx.destination);
            // Native audio goes out here normally too
            source.connect(audioCtx.destination); 
            
            scriptNode.onaudioprocess = (audioProcessingEvent) => {
                const inputBuffer = audioProcessingEvent.inputBuffer;
                const float32Data = inputBuffer.getChannelData(0);
                // Send Float32Array chunk to Worker
                aiWorker.postMessage({ type: 'audio_chunk', data: float32Data, lang: targetLang });
            };
            video.dataset.aiRouted = 'true';
        }
    } catch(e) { console.warn("Audio Context limits", e); }
    
    aiWorker.postMessage(JSON.stringify({ type: 'process', url: videoUrl, targetLang: targetLang }));
};

window.stopAudioPipeline = function() {
    if (aiWorker) {
        aiWorker.postMessage(JSON.stringify({ type: 'stop' }));
    }
};
