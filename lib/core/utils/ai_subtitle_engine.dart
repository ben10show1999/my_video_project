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
      _worker = web.Worker('ai_worker.js'.toJS); // ✅ Type Mismatch Fixed
      _worker!.onmessage = (web.Event e) {
        try {
          final dataStr = ((e as web.MessageEvent).data as JSString).toDart;
          final data = jsonDecode(dataStr);
          if (data['status'] == 'loading_model') { isModelLoading.value = true; }
          else if (data['status'] == 'ready') { isModelLoading.value = false; _isLoaded = true; }
          else if (data['status'] == 'subtitle') { currentSubtitle.value = data['text']; }
        } catch (_) {}
      }.toJS;
    } catch (_) {}
  }

  static void processVideo(String videoUrl, String targetLang) {
    if (!kIsWeb || _worker == null) return;
    if (!_isLoaded) { _worker!.postMessage(jsonEncode({'type': 'init'}).toJS); }
    _worker!.postMessage(jsonEncode({'type': 'process', 'url': videoUrl, 'targetLang': targetLang}).toJS);
  }

  static void stop() {
    currentSubtitle.value = "";
    if (kIsWeb && _worker != null) _worker!.postMessage(jsonEncode({'type': 'stop'}).toJS);
  }
}
