import 'package:my_video_project/data/models/movie_models.dart';

class MockData {
  static const String _img = "https://iili.io/fZAinLv.webp";
  
  // Real Vodu Links provided by user (Task 8 & 29)
  static final List<MovieModel> allMovies = [
    MovieModel(
      id: 1, 
      title: "Batal Al Alam (Testing Stream)", 
      overview: "A test implementation using Vodu sources to verify the Intelligent Source Selector and Hybrid Adaptive Manager. This text simulates a long description to ensure the layout handles it correctly without clipping.", 
      posterPath: _img, 
      seasons: [
        SeasonModel(id: "s1", title: "Season 1", episodes: [
           EpisodeModel(
             id: "s1e1", title: "Episode 1", duration: "45:00", seasonNumber: 1, episodeNumber: 1, 
             sources: [
               // Multiple links for 1080p
               VideoQualityModel(quality: "1080p", urls: [
                 "https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-1080.mp4",
                 "https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-1080.mp4", // Duplicate for testing failover
               ]),
               // Multiple links for 480p
               VideoQualityModel(quality: "480p", urls: [
                 "https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-360.mp4",
               ]),
               // Multiple links for 240p
               VideoQualityModel(quality: "240p", urls: [
                 "https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-t.mp4",
                 "https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-t.mp4",
                 "https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-t.mp4",
               ]),
             ]
           )
        ])
      ]
    ),
    ...List.generate(10, (i) => MovieModel(id: 10+i, title: "Movie ${i+1}", overview: "Generated movie description that is long enough to test expandable text widget...", posterPath: _img, seasons: [])),
  ];
}
