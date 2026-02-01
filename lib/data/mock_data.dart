import 'models/movie_models.dart';
class MockData {
  static const String _vid = "https://user-images.githubusercontent.com/28053651/202696586-48e7996a-7485-414f-8484-a5416297ea42.mp4";
  static const String _img = "https://via.placeholder.com/300x450";
  
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
      title: "Dart Deep Dive", 
      overview: "Explore the depths of the Dart programming language. Understand async programming, isolates, and memory management.", 
      posterPath: _img, 
      seasons: [
        SeasonModel(id: "s1", title: "Season 1", episodes: List.generate(3, (i) => EpisodeModel(id: "d1e$i", title: "Core Concepts ${i+1}", duration: "15:00", seasonNumber: 1, episodeNumber: i+1, sources: [VideoQualityModel(quality: "720p", urls: [_vid])])))
      ]
    ),
    MovieModel(
      id: 3, 
      title: "State Management Wars", 
      overview: "Provider vs Riverpod vs Bloc. Which one should you choose? A comparative analysis of state management solutions.", 
      posterPath: _img, 
      seasons: []
    ),
    ...List.generate(10, (i) => MovieModel(id: 10+i, title: "Flutter Widget of the Week ${i+1}", overview: "A quick look at widget $i.", posterPath: _img, seasons: [])),
  ];
}
