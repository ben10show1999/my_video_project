class AppNotification {
  final String id; final String title; final String body; final String time; 
  final String? targetId; final String? payload; final String? imageUrl;
  AppNotification({required this.id, required this.title, required this.body, required this.time, this.targetId, this.payload, this.imageUrl});
  factory AppNotification.fromJson(Map<String, dynamic> json, String docId) => AppNotification(
    id: docId, title: json['title'] ?? '', body: json['body'] ?? '', 
    time: json['time'] ?? '', targetId: json['targetId'], payload: json['payload'], imageUrl: json['imageUrl']
  );
}
class VideoQualityModel {
  final String quality; final List<String> urls;
  int get numericQuality { final m = RegExp(r'\d+').firstMatch(quality); return m != null ? int.parse(m.group(0)!) : 0; }
  VideoQualityModel({required this.quality, required this.urls});
  factory VideoQualityModel.fromJson(Map<String, dynamic> json) => VideoQualityModel(quality: json['quality'] ?? '', urls: List<String>.from(json['urls'] ?? []));
}
class EpisodeModel {
  final String id; final String title; final String? thumbnailUrl; final String duration;
  final int seasonNumber; final int episodeNumber;
  final List<VideoQualityModel> sources; final Map<String, String> subtitles; 
  EpisodeModel({required this.id, required this.title, this.thumbnailUrl, required this.duration, required this.seasonNumber, required this.episodeNumber, required this.sources, required this.subtitles});
  factory EpisodeModel.fromJson(Map<String, dynamic> json) => EpisodeModel(
    id: json['id'] ?? '', title: json['title'] ?? '', thumbnailUrl: json['thumbnailUrl'], duration: json['duration'] ?? '', seasonNumber: json['seasonNumber'] ?? 1, episodeNumber: json['episodeNumber'] ?? 1, 
    sources: (json['sources'] as List?)?.map((e) => VideoQualityModel.fromJson(e)).toList() ?? [], subtitles: Map<String, String>.from(json['subtitles'] ?? {})
  );
}
class SeasonModel { 
  final String id; final String title; final List<EpisodeModel> episodes; 
  SeasonModel({required this.id, required this.title, required this.episodes}); 
  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(id: json['id'] ?? '', title: json['title'] ?? '', episodes: (json['episodes'] as List?)?.map((e) => EpisodeModel.fromJson(e)).toList() ?? []);
}
class MovieModel { 
  final String id; final String title; final String overview; final String posterPath; 
  final List<SeasonModel> seasons; final String? adScript;
  final String? rating; final String? releaseYear; final String? ageRating;
  final String? infoIconUrl; final String? infoNote;
  const MovieModel({required this.id, required this.title, required this.overview, required this.posterPath, this.seasons = const [], this.adScript, this.rating, this.releaseYear, this.ageRating, this.infoIconUrl, this.infoNote}); 
  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(id: json['id'] ?? '', title: json['title'] ?? '', overview: json['overview'] ?? '', posterPath: json['posterPath'] ?? '', adScript: json['adScript'], rating: json['rating'], releaseYear: json['releaseYear'], ageRating: json['ageRating'], infoIconUrl: json['infoIconUrl'], infoNote: json['infoNote'], seasons: (json['seasons'] as List?)?.map((e) => SeasonModel.fromJson(e)).toList() ?? []);
}
class MovieSnippet { 
  final String id; final String imageUrl; final String title; 
  MovieSnippet({required this.id, required this.imageUrl, required this.title}); 
  factory MovieSnippet.fromJson(Map<String, dynamic> json) => MovieSnippet(id: json['id'] ?? '', imageUrl: json['imageUrl'] ?? '', title: json['title'] ?? '');
}
class SectionModel {
  final String title; final bool showTitles; final List<MovieSnippet> items;
  SectionModel({required this.title, required this.showTitles, required this.items});
  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(title: json['title'] ?? '', showTitles: json['showTitles'] ?? true, items: (json['items'] as List?)?.map((e) => MovieSnippet.fromJson(e)).toList() ?? []);
}
class HeroDataModel {
  final String title; final String posterUrl; final String targetId; final bool isExternal; final String? externalUrl;
  HeroDataModel({required this.title, required this.posterUrl, required this.targetId, required this.isExternal, this.externalUrl});
  factory HeroDataModel.fromJson(Map<String, dynamic> json) => HeroDataModel(title: json['title'] ?? '', posterUrl: json['posterUrl'] ?? '', targetId: json['targetId'] ?? '', isExternal: json['isExternal'] ?? false, externalUrl: json['externalUrl']);
}
