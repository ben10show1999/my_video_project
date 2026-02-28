import 'package:my_video_project/data/models/movie_models.dart';

class MockData {
  static const String _img = "https://iili.io/fZAinLv.webp";
  
  static final List<VideoQualityModel> _ep1Sources = [
    VideoQualityModel(quality: "1080p", urls: ["https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-1080.mp4"]),
    VideoQualityModel(quality: "480p", urls: ["https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-360.mp4"]),
    VideoQualityModel(quality: "240p", urls: ["https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-t.mp4"]),
  ];

  static final List<VideoQualityModel> _ep2Sources = [
    VideoQualityModel(quality: "1080p", urls: ["https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E02_1768839782-1080.mp4"]),
    VideoQualityModel(quality: "480p", urls: ["https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E02_1768839782-360.mp4"]),
    VideoQualityModel(quality: "240p", urls: ["https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E02_1768839782-t.mp4"]),
  ];

  static final List<MovieModel> allMovies = [
    MovieModel(
      id: 1, 
      title: "Batal Al Alam (Absolute Master)", 
      overview: "Final Build: Queue Memory Fix, Ghost Error Suppressor, Native Web Fullscreen, Inline Ads.", 
      posterPath: _img, 
      seasons: [
        SeasonModel(id: "s1", title: "Season 1", episodes: [
          EpisodeModel(id: "s1e1", title: "Episode 1", duration: "45:00", seasonNumber: 1, episodeNumber: 1, sources: _ep1Sources),
          EpisodeModel(id: "s1e2", title: "Episode 2", duration: "48:10", seasonNumber: 1, episodeNumber: 2, sources: _ep2Sources),
          EpisodeModel(id: "s1e3", title: "Episode 3", duration: "41:20", seasonNumber: 1, episodeNumber: 3, sources: _ep1Sources),
        ])
      ]
    ),
    ...List.generate(10, (i) => MovieModel(id: 10+i, title: "Movie ${i+1}", overview: "Generated content.", posterPath: _img, seasons: [])),
  ];
}
