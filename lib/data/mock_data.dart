import 'package:my_video_project/data/models/movie_models.dart';

class MockData {
  static const String _img = "https://iili.io/fZAinLv.webp";
  
  static final List<VideoQualityModel> _videoSources = [
    VideoQualityModel(
      quality: "1080p", 
      urls: [
        "https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-1080.mp4",
        "https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-1080.mp4" 
      ]
    ),
    VideoQualityModel(
      quality: "480p", 
      urls: [
        "https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-360.mp4",
        "https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-360.mp4"
      ]
    ),
    VideoQualityModel(
      quality: "240p", 
      urls: [
        "https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-t.mp4",
        "https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-t.mp4",
        "https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-t.mp4"
      ]
    ),
  ];

  static final List<MovieModel> allMovies = [
    MovieModel(
      id: 1, 
      title: "Batal Al Alam (Final Build)", 
      overview: "Testing the Diamond Build with Immortal Ads and Smart Link Race.", 
      posterPath: _img, 
      seasons: [
        SeasonModel(id: "s1", title: "Season 1", episodes: List.generate(5, (i) => EpisodeModel(id: "s1e$i", title: "Episode ${i+1}", duration: "45:00", seasonNumber: 1, episodeNumber: i+1, sources: _videoSources)))
      ]
    ),
    ...List.generate(10, (i) => MovieModel(id: 10+i, title: "Movie ${i+1}", overview: "Generated content.", posterPath: _img, seasons: [])),
  ];
}
