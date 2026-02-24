import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

class ThumbnailCache {
  // 1. Memory Caching Dictionary
  static final Map<String, Uint8List> _cache = {};

  // 2. Lazy Generation Engine via Off-screen Video Element
  static Future<Uint8List?> getThumbnail(String videoUrl) async {
    if (_cache.containsKey(videoUrl)) return _cache[videoUrl];
    if (!kIsWeb) return null; // Fallback for non-web environments

    final completer = Completer<Uint8List?>();

    try {
      final video = web.document.createElement('video') as web.HTMLVideoElement;
      video.crossOrigin = 'anonymous'; // Attempt to bypass CORS
      video.muted = true;
      video.preload = 'metadata';
      video.src = videoUrl;

      video.onLoadedData.listen((_) {
        // Seek to 3 seconds for the thumbnail frame
        video.currentTime = 3.0; 
      });

      video.onSeeked.listen((_) {
        try {
          // Draw Frame to Canvas
          final canvas = web.document.createElement('canvas') as web.HTMLCanvasElement;
          canvas.width = video.videoWidth;
          canvas.height = video.videoHeight;
          final ctx = canvas.getContext('2d') as web.CanvasRenderingContext2D;
          
          ctx.drawImage(video, 0, 0, canvas.width.toDouble(), canvas.height.toDouble());
          
          // Extract Image Data
          final dataUrl = canvas.toDataURL('image/jpeg', 0.5.toJS);
          final base64String = dataUrl.split(',').last;
          final bytes = base64Decode(base64String);
          
          _cache[videoUrl] = bytes; // Save to Memory Cache
          if (!completer.isCompleted) completer.complete(bytes);
        } catch (e) {
          // Tainted Canvas Fallback (CORS blockage)
          if (!completer.isCompleted) completer.complete(null);
        }
      });

      video.onError.listen((_) {
        if (!completer.isCompleted) completer.complete(null);
      });

      video.load();

      // Failsafe timeout
      Future.delayed(const Duration(seconds: 5), () {
        if (!completer.isCompleted) completer.complete(null);
      });

    } catch (e) {
      if (!completer.isCompleted) completer.complete(null);
    }

    return completer.future;
  }
}
