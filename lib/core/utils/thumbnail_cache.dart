import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

class ThumbnailCache {
  // Memory Caching Dictionary
  static final Map<String, Uint8List> _cache = {};

  // Lazy Generation Engine with Silent Auto-Retry Loop
  static Future<Uint8List?> getThumbnail(String videoUrl, {int retries = 3}) async {
    if (_cache.containsKey(videoUrl)) return _cache[videoUrl];
    if (!kIsWeb) return null; // Fallback for non-web environments

    for (int attempt = 1; attempt <= retries; attempt++) {
      try {
        final bytes = await _extractFrame(videoUrl);
        if (bytes != null) {
          _cache[videoUrl] = bytes; // Save to Memory Cache
          return bytes;
        }
      } catch (e) {
        // Suppress and loop to next attempt
      }
      // Delay before next silent attempt to bypass browser throttling
      if (attempt < retries) await Future.delayed(const Duration(milliseconds: 500));
    }
    return null;
  }

  static Future<Uint8List?> _extractFrame(String videoUrl) {
    final completer = Completer<Uint8List?>();
    try {
      final video = web.document.createElement('video') as web.HTMLVideoElement;
      video.crossOrigin = 'anonymous'; // Attempt to bypass CORS
      video.muted = true;
      video.preload = 'metadata';
      video.src = videoUrl;

      video.onLoadedData.listen((_) { video.currentTime = 3.0; }); // Seek to 3s

      video.onSeeked.listen((_) {
        try {
          final canvas = web.document.createElement('canvas') as web.HTMLCanvasElement;
          canvas.width = video.videoWidth;
          canvas.height = video.videoHeight;
          final ctx = canvas.getContext('2d') as web.CanvasRenderingContext2D;
          
          ctx.drawImage(video, 0, 0, canvas.width.toDouble(), canvas.height.toDouble());
          final dataUrl = canvas.toDataURL('image/jpeg', 0.5.toJS);
          final base64String = dataUrl.split(',').last;
          
          if (!completer.isCompleted) completer.complete(base64Decode(base64String));
        } catch (e) {
          if (!completer.isCompleted) completer.completeError(e); // Tainted Canvas
        }
      });

      video.onError.listen((_) { if (!completer.isCompleted) completer.completeError('Load Error'); });
      video.load();

      // Failsafe timeout for each attempt
      Future.delayed(const Duration(seconds: 4), () {
        if (!completer.isCompleted) completer.completeError('Timeout');
      });

    } catch (e) {
      if (!completer.isCompleted) completer.completeError(e);
    }
    return completer.future;
  }
}
