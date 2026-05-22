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
    
    try {
      final rc = FirebaseRemoteConfig.instance;
      
      // إعدادات Remote Config: جلب البيانات فوراً في بيئة التطوير، ويمكنك تعديلها لاحقاً
      await rc.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 1), // للحصول على التحديث اللحظي بدون Deploy
      ));
      
      await rc.fetchAndActivate();

      // 1. استخراج الروابط المغلفة والرمز السري من Firebase Console
      final String urlsJsonString = rc.getString('webapp_urls');
      final String secretToken = rc.getString('app_secret_token');
      
      List<String> failoverUrls = [];
      try {
        if (urlsJsonString.isNotEmpty) {
          failoverUrls = List<String>.from(jsonDecode(urlsJsonString));
        }
      } catch (e) {
        debugPrint("Error parsing failover URLs from Remote Config: $e");
      }

      // توفير رابط احتياطي صلب (Hardcoded Fallback) في حال فشل الاتصال بـ Firebase
      if (failoverUrls.isEmpty) {
        failoverUrls = ["https://raw.githubusercontent.com/ben10show1999/club_1/refs/heads/main/config.json"];
      }

      // 2. محرك Multi-URL Failover: المرور على الروابط واحداً تلو الآخر
      for (String url in failoverUrls) {
        try {
          final String cacheBuster = DateTime.now().millisecondsSinceEpoch.toString();
          final Uri targetUri = Uri.parse("$url?v=$cacheBuster");
          
          // 3. حقن الرمز السري في الهيدر (لن يظهر في الـ URL أبداً)
          final response = await http.get(
            targetUri,
            headers: {
              "X-App-Token": secretToken.isNotEmpty ? secretToken : "DEFAULT_SECURE_TOKEN_V1",
              "Accept": "application/json"
            }
          ).timeout(const Duration(seconds: 8)); // مهلة قصيرة للانتقال السريع للرابط التالي عند التعطل
          
          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            _parseData(data);
            _isLoaded = true;
            debugPrint("✅ Config loaded successfully from: $url");
            return true; // نجاح! الخروج من حلقة الـ Failover
          } else {
            debugPrint("⚠️ URL responded with ${response.statusCode}: $url");
          }
        } catch (e) {
          debugPrint("🚫 Failover: URL failed, switching to next... $url");
          continue; // فشل الاتصال؟ انتقل فوراً للرابط التالي في المصفوفة
        }
      }
      
      return false; // جميع الروابط تعطلت
    } catch (e) {
      debugPrint("Remote Config Engine Error: $e");
      return false; 
    }
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
