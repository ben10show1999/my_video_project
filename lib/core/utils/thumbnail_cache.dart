import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

class ThumbnailCache {
  static final Map<String, Uint8List> _cache = {};
  static bool _isProcessing = false;
  static bool _isAborted = false;
  static final List<Function> _queue = [];

  static void abortAll() {
    _queue.clear();
    _isAborted = true;
    Future.delayed(const Duration(milliseconds: 200), () => _isAborted = false);
  }

  static Future<Uint8List?> getThumbnail(String videoUrl, {int retries = 3}) async {
    if (_cache.containsKey(videoUrl)) {
      return _cache[videoUrl];
    }
    if (!kIsWeb) {
      return null;
    }

    final completer = Completer<Uint8List?>();

    _queue.add(() async {
      if (_isAborted) { 
        completer.completeError('Aborted'); 
        return; 
      }
      
      Uint8List? result;
      for (int attempt = 1; attempt <= retries; attempt++) {
        if (_isAborted) {
          break;
        }
        try {
          result = await _extractFrame(videoUrl).timeout(const Duration(seconds: 3));
          if (result != null) {
            break;
          }
        } catch (e) {
          if (attempt < retries) {
            await Future.delayed(const Duration(milliseconds: 500));
          }
        }
      }
      if (result != null) {
        _cache[videoUrl] = result;
      }
      if (!completer.isCompleted) {
        completer.complete(result);
      }
    });

    _processQueue();
    return completer.future;
  }

  static void _processQueue() async {
    if (_isProcessing || _queue.isEmpty) {
      return;
    }
    _isProcessing = true;
    
    while (_queue.isNotEmpty) {
      if (_isAborted) { 
        _queue.clear(); 
        break; 
      }
      final task = _queue.removeAt(0);
      await task();
      await Future.delayed(Duration.zero); 
    }
    _isProcessing = false;
  }

  static Future<Uint8List?> _extractFrame(String videoUrl) {
    final completer = Completer<Uint8List?>();
    web.HTMLVideoElement? video;
    web.HTMLCanvasElement? canvas;

    void cleanup() {
      try {
        // ✅ Fixed: Using Safe Call operator ?. prevents unchecked null errors in closures
        video?.removeAttribute('src'); 
        video?.load(); 
        video?.remove(); 
        
        canvas?.width = 0; 
        canvas?.height = 0; 
        canvas?.remove(); 
      } catch (_) {}
    }

    try {
      video = web.document.createElement('video') as web.HTMLVideoElement;
      video.crossOrigin = 'anonymous'; video.muted = true; video.playsInline = true;
      video.preload = 'auto'; video.setAttribute('disableRemotePlayback', 'true'); 
      video.src = videoUrl;

      video.onLoadedData.listen((_) { 
        if (_isAborted) { 
          cleanup(); 
          return; 
        }
        video?.currentTime = 3.0; 
      });

      video.onSeeked.listen((_) async {
        if (_isAborted) { 
          cleanup(); 
          return; 
        }
        try {
          final localVideo = video;
          if (localVideo == null) {
            cleanup();
            if (!completer.isCompleted) completer.completeError('Video null');
            return;
          }

          final localCanvas = web.document.createElement('canvas') as web.HTMLCanvasElement;
          canvas = localCanvas; // Assign to outer scope for cleanup

          localCanvas.width = localVideo.videoWidth; 
          localCanvas.height = localVideo.videoHeight;
          final ctx = localCanvas.getContext('2d') as web.CanvasRenderingContext2D;
          ctx.drawImage(localVideo, 0, 0, localCanvas.width.toDouble(), localCanvas.height.toDouble());
          
          await Future.delayed(Duration.zero);
          
          final dataUrl = localCanvas.toDataURL('image/jpeg', 0.5.toJS);
          final base64String = dataUrl.split(',').last;
          
          cleanup();
          if (!completer.isCompleted) {
            completer.complete(base64Decode(base64String));
          }
        } catch (e) {
          cleanup();
          if (!completer.isCompleted) {
            completer.completeError(e); 
          }
        }
      });
      video.onError.listen((_) { 
        cleanup(); 
        if (!completer.isCompleted) {
          completer.completeError('Load Error'); 
        }
      });
      video.load();
    } catch (e) { 
      cleanup(); 
      if (!completer.isCompleted) {
        completer.completeError(e); 
      }
    }
    return completer.future;
  }
}
