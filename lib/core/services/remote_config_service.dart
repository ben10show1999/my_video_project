import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_video_project/data/models/movie_models.dart';

class RemoteConfigService {
  static const String _githubUrl = "https://raw.githubusercontent.com/ben10show1999/club_1/refs/heads/main/config.json"; 
  
  static String? appLogoUrl; static String? globalAdScript; static HeroDataModel? heroData;
  static List<SectionModel> homeSections = []; static Map<String, MovieModel> moviesDb = {};
  static List<MovieSnippet> searchSuggestions = []; static List<MovieSnippet> allSnippets = []; 
  
  static String? sniperWebToken;
  
  // 🎯 الخزنة الاستاتيكية لحفظ المعرف المقنص مبكراً أثناء عملية الإقلاع
  static String? pendingTargetId;

  static bool _isLoaded = false;
  static bool get isLoaded => _isLoaded;

  static String _decrypt(String input) { try { if (input.startsWith('ENC:')) { return utf8.decode(base64Decode(input.substring(4))); } return input; } catch (_) { return input; } }

  static Future<bool> fetchConfig({bool forceRefresh = false}) async {
    if (_isLoaded && !forceRefresh) return true;
    try {
      final String cacheBuster = DateTime.now().millisecondsSinceEpoch.toString();
      final Uri targetUri = Uri.parse("$_githubUrl?v=$cacheBuster");
      final response = await http.get(targetUri).timeout(const Duration(seconds: 15));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _parseData(data);
        _isLoaded = true;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Remote Config Fetch Error: $e");
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
