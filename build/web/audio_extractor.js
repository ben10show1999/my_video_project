window.AudioExtractor = {
  audioCtx: null, stream: null, source: null, processor: null, worker: null,
  init: function(w) { this.worker = w; },
  start: function(lang) {
    const video = document.querySelector('video');
    if (!video) return;
    try {
      this.audioCtx = new (window.AudioContext || window.webkitAudioContext)({ sampleRate: 16000 });
      // Use captureStream to prevent desync or muting the native video playback
      this.stream = video.captureStream ? video.captureStream() : video.mozCaptureStream();
      if (!this.stream) return;
      
      this.source = this.audioCtx.createMediaStreamSource(this.stream);
      this.processor = this.audioCtx.createScriptProcessor(4096, 1, 1);
      
      this.source.connect(this.processor);
      this.processor.connect(this.audioCtx.destination);
      
      this.processor.onaudioprocess = (e) => {
        if(this.worker) {
          const data = e.inputBuffer.getChannelData(0);
          this.worker.postMessage({ type: 'audio_chunk', data: data, targetLang: lang });
        }
      };
    } catch(e) { console.error("AudioExtractor Error", e); }
  },
  stop: function() {
    if (this.processor) { this.processor.disconnect(); this.processor = null; }
    if (this.source) { this.source.disconnect(); this.source = null; }
    if (this.audioCtx) { this.audioCtx.close(); this.audioCtx = null; }
  }
};
