import 'package:my_video_project/data/models/movie_models.dart';

class MockData {
  static const String _img = "https://iili.io/fZAinLv.webp";
  
  static final List<VideoQualityModel> _ep1Sources = [
    VideoQualityModel(quality: "1080p", urls: ["https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-1080.mp4"]),
    VideoQualityModel(quality: "480p", urls: ["https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-360.mp4"]),
    VideoQualityModel(quality: "240p", urls: ["https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-t.mp4"]),
  ];

  static final List<MovieModel> allMovies = [
    MovieModel(
      id: 1, 
      title: "The Apex Architecture (VOD)", 
      overview: "Full UI Restored. Client-Side AI, Service Worker Decoys, DRM Bridge, Floating Resume Bar.", 
      posterPath: _img, 
      seasons: [
        SeasonModel(id: "s1", title: "Season 1", episodes: [
          EpisodeModel(id: "s1e1", title: "Episode 1", duration: "45:00", seasonNumber: 1, episodeNumber: 1, sources: _ep1Sources),
        ])
      ]
    ),
    MovieModel(
      id: 2, 
      title: "Live News Channel (Live Stream)", 
      overview: "Testing the live stream bypass for the resume bar.", 
      posterPath: _img, 
      seasons: [
        SeasonModel(id: "s1", title: "Live", episodes: [
          EpisodeModel(id: "live", title: "24/7 Stream", duration: "0:00", seasonNumber: 1, episodeNumber: 1, sources: [VideoQualityModel(quality: "Auto", urls: ["https://live.example.com/stream.m3u8"])]),
        ])
      ]
    ),
    ...List.generate(10, (i) => MovieModel(id: 10+i, title: "Movie ${i+3}", overview: "Generated content.", posterPath: _img, seasons: [])),
  ];
}
