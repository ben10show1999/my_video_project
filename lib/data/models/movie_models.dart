class VideoQualityModel {
  final String quality; 
  final List<String> urls; // Support multiple links per quality (Task 29)
  VideoQualityModel({required this.quality, required this.urls});
}
class EpisodeModel {
  final String id; final String title; final String? thumbnailUrl; final String duration;
  final int seasonNumber; final int episodeNumber;
  final List<VideoQualityModel> sources;
  EpisodeModel({required this.id, required this.title, this.thumbnailUrl, required this.duration, required this.seasonNumber, required this.episodeNumber, required this.sources});
}
class SeasonModel { final String id; final String title; final List<EpisodeModel> episodes; SeasonModel({required this.id, required this.title, required this.episodes}); }
class MovieModel { final int id; final String title; final String overview; final String posterPath; final List<SeasonModel> seasons; const MovieModel({required this.id, required this.title, required this.overview, required this.posterPath, this.seasons = const []}); }
class MovieSnippet { final String id; final String imageUrl; final String title; MovieSnippet({required this.id, required this.imageUrl, required this.title}); }
