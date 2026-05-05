import 'dart:async';
import 'dart:convert';
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

  static Future<void> loadSubtitles(String requestedKey, Map<String, String> availableSubs) async {
    String url = "";

    if (requestedKey == "Auto") {
      final sysLang = PlatformDispatcher.instance.locale.languageCode;
      if (availableSubs.containsKey(sysLang)) { url = availableSubs[sysLang]!; } 
      else if (availableSubs.containsKey("original")) { url = availableSubs["original"]!; } 
      else if (availableSubs.isNotEmpty) { url = availableSubs.values.first; }
    } else if (availableSubs.containsKey(requestedKey)) {
      url = availableSubs[requestedKey]!;
    }

    if (url.isEmpty || url == _currentUrl) return;

    _isLoading = true; _currentUrl = url; _cues.clear(); currentSubtitle.value = "";

    try {
      if (url.startsWith('ENC:')) { url = utf8.decode(base64Decode(url.substring(4))); }
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) { _parseVtt(response.body); }
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
    if (start != null && end != null && textBuffer.isNotEmpty) { _cues.add(SubtitleCue(start, end, textBuffer.trim())); }
  }

  static Duration _parseTime(String timeStr) {
    final parts = timeStr.split(':');
    if (parts.length == 3) {
      final secParts = parts[2].split('.');
      return Duration(hours: int.parse(parts[0]), minutes: int.parse(parts[1]), seconds: int.parse(secParts[0]), milliseconds: secParts.length > 1 ? int.parse(secParts[1]) : 0);
    } else if (parts.length == 2) {
      final secParts = parts[1].split('.');
      return Duration(minutes: int.parse(parts[0]), seconds: int.parse(secParts[0]), milliseconds: secParts.length > 1 ? int.parse(secParts[1]) : 0);
    }
    return Duration.zero;
  }

  static void updatePosition(Duration position) {
    if (_cues.isEmpty || _isLoading) return;
    for (var cue in _cues) {
      if (position >= cue.start && position <= cue.end) {
        if (currentSubtitle.value != cue.text) { currentSubtitle.value = cue.text; }
        return;
      }
    }
    if (currentSubtitle.value.isNotEmpty) currentSubtitle.value = "";
  }

  static void stop() { currentSubtitle.value = ""; _cues.clear(); _currentUrl = ""; }
}
