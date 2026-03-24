import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

class AiSubtitleEngine {
  static web.Worker? _worker;
  static bool _isLoaded = false;
  static final ValueNotifier<String> currentSubtitle = ValueNotifier<String>("");
  static final ValueNotifier<bool> isModelLoading = ValueNotifier<bool>(false);

  static void initWorker() {
    if (!kIsWeb || _worker != null) return;
    try {
      _worker = web.Worker('ai_worker.js'.toJS);
      _worker!.onmessage = (web.Event e) {
        try {
          final dataStr = ((e as web.MessageEvent).data as JSString).toDart;
          final data = jsonDecode(dataStr);
          if (data['status'] == 'loading_model') { isModelLoading.value = true; }
          else if (data['status'] == 'ready') { isModelLoading.value = false; _isLoaded = true; }
          else if (data['status'] == 'subtitle') { currentSubtitle.value = data['text']; }
        } catch (_) { }
      }.toJS;
    } catch (_) { }
  }

  static void processVideo(String videoUrl, String requestedLang) {
    if (!kIsWeb || _worker == null) return;
    String targetLang = requestedLang == "Auto" ? PlatformDispatcher.instance.locale.languageCode : requestedLang.substring(0, 2).toLowerCase();
    if (!_isLoaded) _worker!.postMessage(jsonEncode({'type': 'init'}).toJS);
    
    _worker!.postMessage(jsonEncode({'type': 'process', 'url': videoUrl, 'targetLang': targetLang}).toJS);
    
    try { web.window.dispatchEvent(web.CustomEvent('start_audio_extraction', web.CustomEventInit(detail: videoUrl.toJS))); } catch (_) {}
  }

  static void stop() {
    currentSubtitle.value = "";
    if (kIsWeb && _worker != null) {
      _worker!.postMessage(jsonEncode({'type': 'stop'}).toJS);
      try { web.window.dispatchEvent(web.Event('stop_audio_extraction')); } catch (_) {}
    }
  }
}
