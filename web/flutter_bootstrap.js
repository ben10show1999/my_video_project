{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  config: {
    suppressMultithreadingWarning: true
  },
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();
    
    await document.fonts.ready;
    await appRunner.runApp();
    
    // [الحل الجذري لـ Skia Tofu]:
    // ننتظر 150 جزء من الثانية بعد رسم الشاشة الأولى لضمان أن Skia قد 
    // قام بتسجيل الخطوط داخلياً واستبدال الـ Tofu بالنصوص الحقيقية خلف الستارة.
    setTimeout(() => {
      const curtain = document.getElementById('app-curtain');
      if (curtain) {
        curtain.style.opacity = '0';
        setTimeout(() => curtain.remove(), 400); // إزالة العنصر من DOM بعد انتهاء الأنيميشن
      }
    }, 150);
  }
});
