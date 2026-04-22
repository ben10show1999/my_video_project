import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SubtitleCue {
  final Duration start; final Duration end; final String text;
  SubtitleCue(this.start, this.end, this.text);
}

class VttSubtitleEngine {
  static final ValueNotifier<String> currentSubtitle = ValueNotifier<String>("");
  static final List<SubtitleCue> _cues = []; 
  static bool _isLoading = false;
  static String _currentUrl = "";

  static Future<void> loadSubtitles(String requestedMode, Map<String, String> subtitleMap) async {
    if (subtitleMap.isEmpty) { stop(); return; }

    String url = "";
    
    if (requestedMode == "Auto") {
      final String sysLang = PlatformDispatcher.instance.locale.languageCode;
      
      if (subtitleMap.containsKey(sysLang)) {
        url = subtitleMap[sysLang]!;
      } else if (subtitleMap.containsKey("original")) {
        url = subtitleMap["original"]!;
      } else {
        url = subtitleMap.values.first;
      }
    } else {
      url = subtitleMap[requestedMode] ?? "";
    }

    if (url.isEmpty || url == _currentUrl) return;

    _isLoading = true;
    _currentUrl = url;
    _cues.clear();
    currentSubtitle.value = "";

    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        _parseVtt(response.body);
      }
    } catch (e) {
      debugPrint("VTT Engine Error: $e");
    } finally {
      _isLoading = false;
    }
  }

  static void _parseVtt(String content) {
    final lines = content.split('\n');
    Duration? start; Duration? end; String textBuffer = "";
    for (var line in lines) {
      line = line.trim();
      if (line.isEmpty || line.startsWith('WEBVTT') || line.startsWith('Kind:') || line.startsWith('Language:')) continue;
      if (line.contains('-->')) {
        if (start != null && end != null && textBuffer.isNotEmpty) {
          _cues.add(SubtitleCue(start, end, textBuffer.trim()));
          textBuffer = "";
        }
        final parts = line.split('-->');
        if (parts.length == 2) {
          start = _parseTime(parts[0].trim());
          end = _parseTime(parts[1].trim());
        }
      } else if (start != null && end != null && !RegExp(r'^\d+$').hasMatch(line)) {
        textBuffer += (textBuffer.isEmpty ? "" : "\n") + line.replaceAll(RegExp(r'<[^>]*>'), ''); 
      }
    }
    if (start != null && end != null && textBuffer.isNotEmpty) _cues.add(SubtitleCue(start, end, textBuffer.trim()));
  }

  static Duration _parseTime(String s) {
    final p = s.split(':');
    if (p.length == 3) {
      final sp = p[2].split('.');
      return Duration(hours: int.parse(p[0]), minutes: int.parse(p[1]), seconds: int.parse(sp[0]), milliseconds: sp.length > 1 ? int.parse(sp[1]) : 0);
    } else if (p.length == 2) {
      final sp = p[1].split('.');
      return Duration(minutes: int.parse(p[0]), seconds: int.parse(sp[0]), milliseconds: sp.length > 1 ? int.parse(sp[1]) : 0);
    }
    return Duration.zero;
  }

  static void updatePosition(Duration position) {
    if (_cues.isEmpty || _isLoading) return;
    for (var cue in _cues) {
      if (position >= cue.start && position <= cue.end) {
        if (currentSubtitle.value != cue.text) currentSubtitle.value = cue.text;
        return;
      }
    }
    if (currentSubtitle.value.isNotEmpty) currentSubtitle.value = "";
  }

  static void stop() { currentSubtitle.value = ""; _cues.clear(); _currentUrl = ""; }
}
