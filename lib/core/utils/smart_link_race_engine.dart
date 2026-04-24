import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class LinkStatus {
  int latencyMs;
  int failCount;
  LinkStatus({this.latencyMs = 99999, this.failCount = 0});
}

// Task 27 & 28: Smart Link Race Engine & Auto-Recovery
class SmartLinkRaceEngine {
  static final Map<String, LinkStatus> _scores = {};

  static Future<String> getBestUrl(List<String> urls) async {
    if (urls.isEmpty) return "";
    if (urls.length == 1) return urls.first;

    List<Future<MapEntry<String, int>>> probes = urls.map((url) async {
      final status = _scores.putIfAbsent(url, () => LinkStatus());
      
      // Strict timeout for broken links (Background check without holding UI)
      int timeoutMs = status.failCount > 2 ? 800 : 2000;
      
      final stopwatch = Stopwatch()..start();
      try {
        // HEAD request to prevent loading video bytes (Zero-Jank)
        final res = await http.head(Uri.parse(url)).timeout(Duration(milliseconds: timeoutMs));
        stopwatch.stop();
        if (res.statusCode >= 200 && res.statusCode < 400) {
          status.latencyMs = stopwatch.elapsedMilliseconds;
          status.failCount = 0; // Fully Recovered
          return MapEntry(url, status.latencyMs);
        } else {
          status.failCount++; status.latencyMs = 99999;
          return MapEntry(url, 99999);
        }
      } catch (e) {
        status.failCount++; status.latencyMs = 99999;
        return MapEntry(url, 99999);
      }
    }).toList();

    final results = await Future.wait(probes);
    results.sort((a, b) => a.value.compareTo(b.value));
    
    // Return fastest valid url, or fallback to first if all fail
    return results.first.value < 99999 ? results.first.key : urls.first;
  }

  static void reportBroken(String url) {
    if (_scores.containsKey(url)) {
      _scores[url]!.failCount++;
      _scores[url]!.latencyMs = 99999;
      debugPrint("LINK RACER: Blacklisted $url");
    }
  }
}
