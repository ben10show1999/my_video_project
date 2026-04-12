import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_video_project/data/models/movie_models.dart';

class RemoteConfigService {
  // Replace this with your actual GitHub Gist Raw URL
  // MAKE SURE it is the "Raw" URL ending in .json
  static const String _gistUrl =
      "https://gist.githubusercontent.com/ben10show1999/db8d13db302f99095ed022da4cdfac47/raw/config.json";

  static HeroDataModel? heroData;
  static List<SectionModel> homeSections = [];
  static Map<String, MovieModel> moviesDb = {};
  static List<MovieSnippet> searchSuggestions = [];
  static List<MovieSnippet> allSnippets = [];

  static bool _isLoaded = false;
  static bool get isLoaded => _isLoaded;

  // Simple decryption example (Task 10: Security). In a real app, use a strong AES library.
  // This decrypts base64 encoded strings from the JSON so they aren't plain text in network logs.
  static String _decrypt(String input) {
    try {
      if (input.startsWith('ENC:')) {
        return utf8.decode(base64Decode(input.substring(4)));
      }
      return input;
    } catch (_) {
      return input;
    }
  }

  static Future<bool> fetchConfig() async {
    if (_isLoaded) return true;
    try {
      final response = await http
          .get(Uri.parse(_gistUrl))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _parseData(data);
        _isLoaded = true;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Remote Config Fetch Error: $e");
      // Fallback Data for safety
      _loadFallbackData();
      return true;
    }
  }

  static void _parseData(Map<String, dynamic> data) {
    if (data['hero'] != null) {
      heroData = HeroDataModel.fromJson(data['hero']);
    }
    if (data['sections'] != null) {
      homeSections = (data['sections'] as List)
          .map((e) => SectionModel.fromJson(e))
          .toList();
    }
    if (data['searchSuggestions'] != null) {
      searchSuggestions = (data['searchSuggestions'] as List)
          .map((e) => MovieSnippet.fromJson(e))
          .toList();
    }

    moviesDb.clear();
    allSnippets.clear();
    if (data['movies_db'] != null) {
      final db = data['movies_db'] as Map<String, dynamic>;
      db.forEach((key, value) {
        moviesDb[key] = MovieModel.fromJson(value);
        allSnippets.add(MovieSnippet(
            id: key, imageUrl: value['posterPath'], title: value['title']));
      });
    }

    // Decrypt URLs (Example of Task 10)
    for (var m in moviesDb.values) {
      for (var s in m.seasons) {
        for (var e in s.episodes) {
          for (var q in e.sources) {
            for (int i = 0; i < q.urls.length; i++) {
              q.urls[i] = _decrypt(q.urls[i]);
            }
          }
        }
      }
    }
  }

  static void _loadFallbackData() {
    heroData = HeroDataModel(
        title: "Flutter Series",
        posterUrl: "https://via.placeholder.com/1920x1080",
        targetId: "1",
        isExternal: false);
    homeSections = [
      SectionModel(title: "Trending", showTitles: true, items: [
        MovieSnippet(
            id: "1",
            imageUrl: "https://iili.io/fZAinLv.webp",
            title: "Fallback Movie")
      ])
    ];
    moviesDb["1"] = MovieModel(
        id: "1",
        title: "Fallback Movie",
        overview: "No Internet Connection.",
        posterPath: "https://iili.io/fZAinLv.webp",
        seasons: [
          SeasonModel(id: "s1", title: "Season 1", episodes: [
            EpisodeModel(
                id: "e1",
                title: "Ep 1",
                duration: "00:00",
                seasonNumber: 1,
                episodeNumber: 1,
                sources: [
                  VideoQualityModel(quality: "Auto", urls: [""])
                ])
          ])
        ]);
    searchSuggestions = homeSections.first.items;
    allSnippets = homeSections.first.items;
  }
}
