import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class _SubtitleCue { 
  final Duration start; final Duration end; String text; 
  _SubtitleCue(this.start, this.end, this.text); 
}

class VttSubtitleEngine {
  static final ValueNotifier<String> currentSubtitle = ValueNotifier<String>("");
  static final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  static final List<_SubtitleCue> _cues = [];

  // VTT Links Provided
  static final Map<String, String> _vttLinks = {
    'ar': 'https://cdn.plyr.io/static/demo/thumbs/100p.vtt',
    'en': 'https://cdn.plyr.io/static/demo/thumbs/240p.vtt',
    'fr': 'https://cdn.plyr.io/static/demo/View_From_A_Blue_Moon_Trailer-HD.en.vtt'
  };

  static Future<void> loadSubtitles(String requestedLang) async {
    stop();
    if (requestedLang == "Off") return;
    
    isLoading.value = true;
    String targetLang = requestedLang;
    
    if (targetLang == "Auto") {
      targetLang = PlatformDispatcher.instance.locale.languageCode.substring(0, 2).toLowerCase();
    } else {
      targetLang = targetLang.substring(0, 2).toLowerCase();
    }

    String url = _vttLinks[targetLang] ?? _vttLinks['en']!;
    
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        _parseVtt(response.body);
      }
    } catch (_) {
      // Fallback silently if CORS blocks or network fails
    }
    isLoading.value = false;
  }

  static void _parseVtt(String vttContent) {
    final lines = vttContent.split('\n');
    _SubtitleCue? currentCue;
    final timeReg = RegExp(r'(\d{2}:\d{2}:\d{2}\.\d{3})\s*-->\s*(\d{2}:\d{2}:\d{2}\.\d{3})');

    for (var line in lines) {
      line = line.trim();
      if (line.isEmpty || line == 'WEBVTT') continue;

      final match = timeReg.firstMatch(line);
      if (match != null) {
        currentCue = _SubtitleCue(_parseTime(match.group(1)!), _parseTime(match.group(2)!), "");
        _cues.add(currentCue);
      } else if (currentCue != null && !line.contains(RegExp(r'^\d+$'))) {
         currentCue.text += (currentCue.text.isEmpty ? "" : "\n") + line;
      }
    }
  }

  static Duration _parseTime(String timeString) {
    final parts = timeString.split(':');
    final secParts = parts[2].split('.');
    return Duration(
      hours: int.parse(parts[0]), minutes: int.parse(parts[1]),
      seconds: int.parse(secParts[0]), milliseconds: int.parse(secParts[1])
    );
  }

  static void syncPosition(Duration position) {
    if (_cues.isEmpty) return;
    for (var cue in _cues) {
      if (position >= cue.start && position <= cue.end) {
        if (currentSubtitle.value != cue.text) currentSubtitle.value = cue.text;
        return;
      }
    }
    if (currentSubtitle.value.isNotEmpty) currentSubtitle.value = "";
  }

  static void stop() {
    _cues.clear();
    currentSubtitle.value = "";
    isLoading.value = false;
  }
}
