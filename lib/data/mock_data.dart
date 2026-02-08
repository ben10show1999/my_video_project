import 'package:my_video_project/data/models/movie_models.dart';

class MockData {
  static const String _img = "https://iili.io/fZAinLv.webp";
  static final List<MovieModel> allMovies = [
    MovieModel(
      id: 1, 
      title: "Batal Al Alam (Diamond Fixed)", 
      overview: "A specialized test for the 'Diamond Build' with fixes applied. No more setProperty errors. Asset directories are created automatically.", 
      posterPath: _img, 
      seasons: [
        SeasonModel(id: "s1", title: "Season 1", episodes: [
           EpisodeModel(
             id: "s1e1", title: "Episode 1", duration: "45:00", seasonNumber: 1, episodeNumber: 1, 
             sources: [
               VideoQualityModel(quality: "1080p", urls: [
                 "https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-1080.mp4",
               ]),
               VideoQualityModel(quality: "480p", urls: [
                 "https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-360.mp4",
               ]),
               VideoQualityModel(quality: "240p", urls: [
                 "https://movie.vodu.me:8888/videos/Batal_Al_Alam_S01_E01_1768757539-t.mp4",
               ]),
             ]
           )
        ])
      ]
    ),
    ...List.generate(10, (i) => MovieModel(id: 10+i, title: "Movie ${i+1}", overview: "Generated movie description...", posterPath: _img, seasons: [])),
  ];
}
