import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:my_video_project/data/models/movie_models.dart';

class RemoteConfigService {
  static String? appLogoUrl; static String? globalAdScript; static HeroDataModel? heroData;
  static List<SectionModel> homeSections = []; static Map<String, MovieModel> moviesDb = {};
  static List<MovieSnippet> searchSuggestions = []; static List<MovieSnippet> allSnippets = []; 
  
  static String? pendingTargetId;
  static bool _isLoaded = false;
  static bool get isLoaded => _isLoaded;

  static String _decrypt(String input) { try { if (input.startsWith('ENC:')) { return utf8.decode(base64Decode(input.substring(4))); } return input; } catch (_) { return input; } }

  static Future<bool> fetchConfig({bool forceRefresh = false}) async {
    if (_isLoaded && !forceRefresh) return true;
    
    final List<String> localFallbackUrls = [
      "https://raw.githubusercontent.com/ben10show1999/club_1/refs/heads/main/config.json"
    ];
    const String localFallbackToken = "DEFAULT_SECURE_TOKEN_V1";

    String urlsJsonString = '["https://raw.githubusercontent.com/ben10show1999/club_1/refs/heads/main/config.json"]';
    String secretToken = localFallbackToken;

    try {
      final rc = FirebaseRemoteConfig.instance;
      
      await rc.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 4), 
        minimumFetchInterval: const Duration(seconds: 1),
      ));
      
      await rc.setDefaults(<String, dynamic>{
        'webapp_urls': urlsJsonString,
        'app_secret_token': secretToken,
      });

      try {
        await rc.fetchAndActivate();
        urlsJsonString = rc.getString('webapp_urls');
        secretToken = rc.getString('app_secret_token');
        debugPrint("🚀 Firebase Remote Config synchronized successfully.");
      } catch (firebaseError) {
        debugPrint("⚠️ Firebase fetch blocked or offline (Using Local Defaults)");
        urlsJsonString = rc.getString('webapp_urls');
        secretToken = rc.getString('app_secret_token');
      }
      
      List<String> failoverUrls = [];
      try {
        if (urlsJsonString.isNotEmpty) {
          failoverUrls = List<String>.from(jsonDecode(urlsJsonString));
        }
      } catch (e) {
        debugPrint("Error parsing URLs string structure: $e");
      }

      if (failoverUrls.isEmpty) {
        failoverUrls = localFallbackUrls;
      }

      for (String url in failoverUrls) {
        try {
          final String cacheBuster = DateTime.now().millisecondsSinceEpoch.toString();
          final Uri targetUri = Uri.parse("$url?v=$cacheBuster");
          
          // 🎯 التوجيه الذكي: عدم إرسال الهيدر السري إذا كان الرابط يخص GitHub لمنع خطأ CORS
          final Map<String, String> requestHeaders = {"Accept": "application/json"};
          if (!url.contains("raw.githubusercontent.com")) {
            requestHeaders["X-App-Token"] = secretToken.isNotEmpty ? secretToken : localFallbackToken;
          }
          
          final response = await http.get(targetUri, headers: requestHeaders).timeout(const Duration(seconds: 6));
          
          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            _parseData(data);
            _isLoaded = true;
            debugPrint("✅ Content deployed perfectly from: $url");
            return true; 
          } else {
            debugPrint("⚠️ Server responded with code ${response.statusCode} for: $url");
          }
        } catch (e) {
          debugPrint("🚫 Failover engaged: Source unreadable, switching to next inline... $url");
          continue; 
        }
      }
      
      if (!_isLoaded) {
        return await _executeAbsoluteFallback(localFallbackUrls.first, localFallbackToken);
      }
      
      return false; 
    } catch (criticalError) {
      debugPrint("Critical Kernel Exception Blocked: $criticalError");
      return await _executeAbsoluteFallback(localFallbackUrls.first, localFallbackToken);
    }
  }

  static Future<bool> _executeAbsoluteFallback(String fallbackUrl, String token) async {
    try {
      debugPrint("🛡️ Executing Absolute Emergency Fallback Channel...");
      final Map<String, String> fallbackHeaders = {"Accept": "application/json"};
      if (!fallbackUrl.contains("raw.githubusercontent.com")) {
        fallbackHeaders["X-App-Token"] = token;
      }
      final response = await http.get(Uri.parse(fallbackUrl), headers: fallbackHeaders).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _parseData(data);
        _isLoaded = true;
        return true;
      }
    } catch (e) {
      debugPrint("Ultimate Fallback Channel Failed.");
    }
    return false;
  }

  static void _parseData(Map<String, dynamic> data) {
    if (data['appConfig'] != null) { appLogoUrl = data['appConfig']['logoUrl']; globalAdScript = data['appConfig']['globalAdScript']; }
    if (data['hero'] != null) { heroData = HeroDataModel.fromJson(data['hero']); }
    if (data['sections'] != null) { homeSections = (data['sections'] as List).map((e) => SectionModel.fromJson(e)).toList(); }
    if (data['searchSuggestions'] != null) { searchSuggestions = (data['searchSuggestions'] as List).map((e) => MovieSnippet.fromJson(e)).toList(); }
    moviesDb.clear(); allSnippets.clear();
    if (data['movies_db'] != null) {
      final db = data['movies_db'] as Map<String, dynamic>;
      db.forEach((key, value) { moviesDb[key] = MovieModel.fromJson(value); allSnippets.add(MovieSnippet(id: key, imageUrl: value['posterPath'], title: value['title'])); });
    }
    for (var m in moviesDb.values) {
       for (var s in m.seasons) { for (var e in s.episodes) { for (var q in e.sources) { for(int i = 0; i < q.urls.length; i++) { q.urls[i] = _decrypt(q.urls[i]); } } } }
    }
  }
}
