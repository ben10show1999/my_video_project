import 'package:my_video_project/data/models/movie_models.dart';

class MockData {
  static const String _vid = "https://user-images.githubusercontent.com/28053651/202696586-48e7996a-7485-414f-8484-a5416297ea42.mp4";
  // �7�3 The Requested Standard Poster
  static const String _img = "https://iili.io/fZAinLv.webp";
  
  static final List<MovieModel> allMovies = [
    MovieModel(
      id: 1, 
      title: "Flutter Mastery: The Complete Guide", 
      overview: "Learn how to build high-performance applications with Flutter. This comprehensive series covers everything from basic widgets to advanced state management and architectural patterns. Perfect for beginners and pros alike.", 
      posterPath: _img, 
      seasons: [
        SeasonModel(id: "s1", title: "Season 1", episodes: List.generate(5, (i) => EpisodeModel(id: "s1e$i", title: "Setup & Basics ${i+1}", duration: "24:00", seasonNumber: 1, episodeNumber: i+1, sources: [VideoQualityModel(quality: "1080p", urls: [_vid])])))
      ]
    ),
    MovieModel(
      id: 2, 
      title: "Dart Deep Dive (4:3 Aspect Test)", 
      overview: "Explore the depths of the Dart programming language. This content is designed to test dynamic aspect ratio adaptation.", 
      posterPath: _img, 
      seasons: [
        SeasonModel(id: "s1", title: "Season 1", episodes: List.generate(3, (i) => EpisodeModel(id: "d1e$i", title: "Core Concepts ${i+1}", duration: "15:00", seasonNumber: 1, episodeNumber: i+1, sources: [VideoQualityModel(quality: "720p", urls: [_vid])])))
      ]
    ),
    ...List.generate(10, (i) => MovieModel(id: 10+i, title: "Movie ${i+1}", overview: "Overview for movie $i. This is a long description to test the expandable text feature which should show a button only if the text is long enough.", posterPath: _img, seasons: [])),
  ];
}
