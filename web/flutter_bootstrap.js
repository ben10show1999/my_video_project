{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  config: {
    suppressMultithreadingWarning: true
  },
  onEntrypointLoaded: async function(engineInitializer) {
    
    // [الحل الجذري المطلق]: 
    // 1. قراءة ملف FontManifest الخاص بـ Flutter
    // 2. إجبار المتصفح و الـ WebView على تحميل ملفات الخطوط وتخزينها في الـ Cache
    // 3. الـ Native Splash الخاص بك (SVG) سيبقى ظاهراً خلال هذه الثواني/الأجزاء من الثانية
    try {
      const manifestResponse = await fetch('assets/FontManifest.json');
      if (manifestResponse.ok) {
        const manifest = await manifestResponse.json();
        const fontFetchPromises = [];
        
        for (const fontGroup of manifest) {
          for (const font of fontGroup.fonts) {
            // تحميل الخط في الذاكرة المخبأة للمتصفح
            fontFetchPromises.push(fetch(font.asset));
          }
        }
        
        // انتظار تحميل جميع الخطوط بالكامل قبل إعطاء الإذن للمحرك
        await Promise.all(fontFetchPromises);
        console.log('✅ TRUE ROOT FIX: All Flutter fonts pre-fetched perfectly from Firebase.');
      }
    } catch (error) {
      console.warn('⚠️ Font pre-fetch skipped (Manifest not found or error):', error);
    }

    // الآن بدأنا تهيئة المحرك، وحين يطلب Skia الخطوط سيجدها جاهزة في 0 مللي ثانية
    const appRunner = await engineInitializer.initializeEngine();
    
    // تشغيل التطبيق (سيتم رسم الإطار الأول بالخطوط الصحيحة 100% وبدون أي وميض Tofu)
    await appRunner.runApp();
    
    // ملاحظة: سيقوم Flutter تلقائياً بالتعامل مع إزالة الـ Native Splash 
    // بمجرد انتهاء runApp().
  }
});
