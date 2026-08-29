{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  config: {
    suppressMultithreadingWarning: true
  },
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();
    
    // [الحل الجذري لظاهرة Tofu]: 
    // إجبار المحرك على عدم رسم واجهة المستخدم (First Frame) 
    // إلا بعد أن يتأكد المتصفح أو الـ WebView من تحميل وفك تشفير جميع الخطوط بالكامل.
    await document.fonts.ready;
    
    await appRunner.runApp();
  }
});
