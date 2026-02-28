import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

class ThumbnailCache {
  static final Map<String, Uint8List> _cache = {};
  static bool _isProcessing = false;
  static final List<Function> _queue = [];

  // Task 5: Concurrency Queue to Prevent Memory Leak & Crashing
  static Future<Uint8List?> getThumbnail(String videoUrl, {int retries = 3}) async {
    if (_cache.containsKey(videoUrl)) return _cache[videoUrl];
    if (!kIsWeb) return null;

    final completer = Completer<Uint8List?>();

    _queue.add(() async {
      Uint8List? result;
      // Task 8: Armored Auto-Retry Loop (Rebuilds element each time)
      for (int attempt = 1; attempt <= retries; attempt++) {
        try {
          result = await _extractFrame(videoUrl);
          if (result != null) break;
        } catch (e) {
          if (attempt < retries) await Future.delayed(const Duration(milliseconds: 500));
        }
      }
      if (result != null) _cache[videoUrl] = result;
      completer.complete(result);
    });

    _processQueue();
    return completer.future;
  }

  static void _processQueue() async {
    if (_isProcessing || _queue.isEmpty) return;
    _isProcessing = true;
    while (_queue.isNotEmpty) {
      final task = _queue.removeAt(0);
      await task();
    }
    _isProcessing = false;
  }

  // Absolute Cleanup Mechanism
  static Future<Uint8List?> _extractFrame(String videoUrl) {
    final completer = Completer<Uint8List?>();
    web.HTMLVideoElement? video;
    web.HTMLCanvasElement? canvas;

    void cleanup() {
      if (video != null) {
        video.removeAttribute('src'); // Stop streaming
        video.load(); // Flush buffer
        video.remove(); // Detach from DOM memory
      }
      if (canvas != null) {
        canvas!.remove(); // Clear drawing memory
      }
    }

    try {
      video = web.document.createElement('video') as web.HTMLVideoElement;
      video.crossOrigin = 'anonymous';
      video.muted = true;
      video.playsInline = true;
      video.preload = 'auto'; // Force load to break suspension
      video.src = videoUrl;

      video.onLoadedData.listen((_) { video!.currentTime = 3.0; });

      video.onSeeked.listen((_) {
        try {
          canvas = web.document.createElement('canvas') as web.HTMLCanvasElement;
          canvas!.width = video!.videoWidth;
          canvas!.height = video.videoHeight;
          final ctx = canvas!.getContext('2d') as web.CanvasRenderingContext2D;
          
          ctx.drawImage(video, 0, 0, canvas!.width.toDouble(), canvas!.height.toDouble());
          final dataUrl = canvas!.toDataURL('image/jpeg', 0.5.toJS);
          final base64String = dataUrl.split(',').last;
          
          cleanup();
          if (!completer.isCompleted) completer.complete(base64Decode(base64String));
        } catch (e) {
          cleanup();
          if (!completer.isCompleted) completer.completeError(e); 
        }
      });

      video.onError.listen((_) {
        cleanup();
        if (!completer.isCompleted) completer.completeError('Load Error');
      });

      video.load();

      Future.delayed(const Duration(seconds: 4), () {
        if (!completer.isCompleted) {
          cleanup();
          completer.completeError('Timeout');
        }
      });
    } catch (e) {
      cleanup();
      if (!completer.isCompleted) completer.completeError(e);
    }
    return completer.future;
  }
}
