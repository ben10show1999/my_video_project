import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

// ✅ Task 8: JS Interop bindings to the Audio Extractor (Zero UI Lag)
@JS('AudioExtractor.init')
external void _initExtractor(web.Worker worker);

@JS('AudioExtractor.start')
external void _startExtractor(JSString lang);

@JS('AudioExtractor.stop')
external void _stopExtractor();

class AiSubtitleEngine {
  static web.Worker? _worker;
  static bool _isLoaded = false;
  static final ValueNotifier<String> currentSubtitle = ValueNotifier<String>("");
  static final ValueNotifier<bool> isModelLoading = ValueNotifier<bool>(false);

  static void initWorker() {
    if (!kIsWeb || _worker != null) return;
    try {
      _worker = web.Worker('ai_worker.js'.toJS);
      _initExtractor(_worker!); // Wire the extractor to the worker
      
      _worker!.onmessage = (web.Event e) {
        try {
          final dataStr = ((e as web.MessageEvent).data as JSString).toDart;
          final data = jsonDecode(dataStr);
          if (data['status'] == 'loading_model') { isModelLoading.value = true; }
          else if (data['status'] == 'ready') { isModelLoading.value = false; _isLoaded = true; }
          else if (data['status'] == 'subtitle') { currentSubtitle.value = data['text']; }
        } catch (_) { /* Ignore errors silently */ }
      }.toJS;
    } catch (_) { /* Ignore unsupported environments */ }
  }

  static void processVideo(String requestedLang) {
    if (!kIsWeb || _worker == null) return;
    
    String targetLang = requestedLang;
    if (targetLang == "Auto") {
      targetLang = PlatformDispatcher.instance.locale.languageCode;
    } else {
      targetLang = targetLang.substring(0, 2).toLowerCase();
    }

    if (!_isLoaded) {
      _worker!.postMessage(jsonEncode({'type': 'init'}).toJS);
    }
    
    // Starts the native audio extraction which pipes Float32Array to the worker
    _startExtractor(targetLang.toJS);
  }

  static void stop() {
    currentSubtitle.value = "";
    if (kIsWeb) _stopExtractor();
  }
}
