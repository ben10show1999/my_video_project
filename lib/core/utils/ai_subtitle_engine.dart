import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

@JS('window.startAiAudio') external void startAiAudio(String targetLang);
@JS('window.stopAiAudio') external void stopAiAudio();

class AiSubtitleEngine {
  static bool _isInitialized = false;
  static final ValueNotifier<String> currentSubtitle = ValueNotifier<String>("");
  static final ValueNotifier<bool> isModelLoading = ValueNotifier<bool>(false);

  static void initWorker() {
    if (!kIsWeb || _isInitialized) return;
    try {
      web.window.addEventListener('ai_subtitle_update', ((web.Event e) {
        try {
          final dataStr = ((e as web.CustomEvent).detail as JSString).toDart;
          final data = jsonDecode(dataStr);
          if (data['status'] == 'loading_model') { isModelLoading.value = true; }
          else if (data['status'] == 'ready') { isModelLoading.value = false; }
          else if (data['status'] == 'subtitle') { currentSubtitle.value = data['text']; }
        } catch (_) { }
      }).toJS);
      _isInitialized = true;
    } catch (_) { }
  }

  static void processVideo(String requestedLang) {
    if (!kIsWeb) return;
    String targetLang = requestedLang == "Auto" ? PlatformDispatcher.instance.locale.languageCode : requestedLang.substring(0, 2).toLowerCase();
    try { startAiAudio(targetLang); } catch (_) {}
  }

  static void stop() {
    currentSubtitle.value = "";
    if (kIsWeb) { try { stopAiAudio(); } catch (_) {} }
  }
}
