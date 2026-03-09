import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

// Interop mapping for our custom JS function in audio_bridge.js
@JS('startAudioPipeline')
external void _startAudioPipeline(JSString videoUrl, JSString targetLang);

@JS('stopAudioPipeline')
external void _stopAudioPipeline();

class AiSubtitleEngine {
  static final ValueNotifier<String> currentSubtitle = ValueNotifier<String>("");
  static final ValueNotifier<bool> isModelLoading = ValueNotifier<bool>(false);
  static late JSFunction _messageListener;

  static void initWorker() {
    if (!kIsWeb) return;
    _messageListener = (web.Event e) {
      try {
        final dataStr = ((e as web.MessageEvent).data as JSString).toDart;
        final data = jsonDecode(dataStr);
        if (data['status'] == 'loading_model') { isModelLoading.value = true; }
        else if (data['status'] == 'ready') { isModelLoading.value = false; }
        else if (data['status'] == 'subtitle') { currentSubtitle.value = data['text']; }
      } catch (_) { /* Ignore non-JSON silently */ }
    }.toJS;
    web.window.addEventListener('ai_bridge_msg', _messageListener);
  }

  static void processVideo(String videoUrl, String requestedLang) {
    if (!kIsWeb) return;
    
    String targetLang = requestedLang;
    if (targetLang == "Auto") {
      targetLang = PlatformDispatcher.instance.locale.languageCode;
    } else {
      targetLang = targetLang.substring(0, 2).toLowerCase();
    }

    try {
      _startAudioPipeline(videoUrl.toJS, targetLang.toJS);
    } catch (e) {
      debugPrint("Audio Pipeline Interop failed: $e");
    }
  }

  static void stop() {
    currentSubtitle.value = "";
    if (kIsWeb) {
      try { _stopAudioPipeline(); } catch (_) {}
    }
  }
}
