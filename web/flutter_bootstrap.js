{{flutter_js}}
{{flutter_build_config}}

// Smart Fallback Negotiator
const isWasmThreadsSupported = window.crossOriginIsolated && typeof SharedArrayBuffer !== 'undefined';

const config = {
  // Try Wasm first if isolated, else fallback silently to JS to prevent crashes
  renderer: isWasmThreadsSupported ? 'canvaskit' : 'html',
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();
    await appRunner.runApp();
  }
};

_flutter.loader.load(config);
