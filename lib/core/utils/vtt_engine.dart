import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class VttCue {
  final Duration start; final Duration end; final String text;
  VttCue(this.start, this.end, this.text);
}

class VttEngine {
  static final ValueNotifier<String> currentSubtitle = ValueNotifier<String>("");
  static final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  static final List<VttCue> _cues = [];
  static String _activeLang = "Off";

  static const Map<String, String> _subLinks = {
    'ar': 'https://cdn.plyr.io/static/demo/thumbs/100p.vtt',
    'en': 'https://cdn.plyr.io/static/demo/thumbs/240p.vtt',
    'fr': 'https://cdn.plyr.io/static/demo/View_From_A_Blue_Moon_Trailer-HD.en.vtt'
  };

  static Future<void> setLanguage(String lang) async {
    String target = lang == "Auto" ? PlatformDispatcher.instance.locale.languageCode.substring(0, 2) : lang.substring(0, 2).toLowerCase();
    _activeLang = lang;
    
    if (lang == "Off" || !_subLinks.containsKey(target)) { _cues.clear(); currentSubtitle.value = ""; return; }
    
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(_subLinks[target]!));
      if (response.statusCode == 200) { _parseVtt(response.body); } else { _cues.clear(); }
    } catch (_) { _cues.clear(); }
    isLoading.value = false;
  }

  static void _parseVtt(String vttContent) {
    _cues.clear();
    final lines = vttContent.split('\n');
    Duration? start, end; String text = "";
    final timePattern = RegExp(r'(\d{2}:)?(\d{2}):(\d{2})\.(\d{3})\s*-->\s*(\d{2}:)?(\d{2}):(\d{2})\.(\d{3})');

    for (var line in lines) {
      line = line.trim();
      if (line.isEmpty || line == 'WEBVTT') continue;
      
      final match = timePattern.firstMatch(line);
      if (match != null) {
        if (text.isNotEmpty && start != null && end != null) { _cues.add(VttCue(start, end, text.trim())); text = ""; }
        start = _parseTime(match.group(1), match.group(2), match.group(3), match.group(4));
        end = _parseTime(match.group(5), match.group(6), match.group(7), match.group(8));
      } else if (!line.contains('-->')) {
        text += (text.isEmpty ? "" : "\n") + line;
      }
    }
    if (text.isNotEmpty && start != null && end != null) { _cues.add(VttCue(start, end, text.trim())); }
  }

  static Duration _parseTime(String? h, String? m, String? s, String? ms) {
    int hrs = h != null ? int.parse(h.replaceAll(':', '')) : 0;
    return Duration(hours: hrs, minutes: int.parse(m!), seconds: int.parse(s!), milliseconds: int.parse(ms!));
  }

  static void updatePosition(Duration pos) {
    if (_cues.isEmpty || _activeLang == "Off") { if (currentSubtitle.value.isNotEmpty) currentSubtitle.value = ""; return; }
    // Binary search could optimize, but simple loop is fine for standard VTT sizes
    for (var cue in _cues) {
      if (pos >= cue.start && pos <= cue.end) {
        if (currentSubtitle.value != cue.text) currentSubtitle.value = cue.text;
        return;
      }
    }
    if (currentSubtitle.value.isNotEmpty) currentSubtitle.value = "";
  }
  
  static void stop() { currentSubtitle.value = ""; _cues.clear(); }
}
