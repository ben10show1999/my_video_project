import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../data/models/movie_models.dart';
import '../components/buttons/action_icon_button.dart';
import '../components/player/smart_media_kit_player.dart';
import 'components/playlist_sidebar.dart';
import 'components/lazy_horizontal_section.dart';

class MovieDetailsScreen extends StatefulWidget { const MovieDetailsScreen({super.key}); @override State<MovieDetailsScreen> createState() => _MovieDetailsScreenState(); }
class _MovieDetailsScreenState extends State<MovieDetailsScreen> { 
  late ScrollController _sc; late MovieModel _mov; late SeasonModel _sea; late EpisodeModel _ep; 
  double _currentAspectRatio = 16/9; 

  @override void initState() { super.initState(); _sc = ScrollController(); _data(); } 
  void _data() { 
    // Mock Data
    String url1 = "https://user-images.githubusercontent.com/28053651/202696586-48e7996a-7485-414f-8484-a5416297ea42.mp4"; 
    _mov = MovieModel(id: 1, title: "Flutter Mastery", overview: "An epic journey into Dart & Flutter.", posterPath: "", seasons: [
      SeasonModel(id: "s1", title: "Season 1", episodes: List.generate(5, (i) => EpisodeModel(id: "s1e$i", title: "S1 Ep ${i+1}", duration: "24:00", seasonNumber: 1, episodeNumber: i+1, sources: [VideoQualityModel(quality: "1080p", urls: [url1])]))),
      SeasonModel(id: "s2", title: "Season 2", episodes: List.generate(10, (i) => EpisodeModel(id: "s2e$i", title: "S2 Ep ${i+1}", duration: "30:00", seasonNumber: 2, episodeNumber: i+1, sources: [VideoQualityModel(quality: "1080p", urls: [url1])]))),
    ]); 
    _sea = _mov.seasons.first; _ep = _sea.episodes.first; 
  }

  void _updateLayoutForVideo(double ratio) { if (mounted && _currentAspectRatio != ratio) setState(() => _currentAspectRatio = ratio); }

  @override Widget build(BuildContext context) { return Scaffold(backgroundColor: AppColors.background, body: LayoutBuilder(builder: (c, cs) => cs.maxWidth > 900 ? _desk() : _mob())); }
  
  Widget _mob() => SingleChildScrollView(controller: _sc, child: Column(children: [AspectRatio(aspectRatio: _currentAspectRatio, child: SmartMediaKitPlayer(sources: _ep.sources, thumbnailUrl: _ep.thumbnailUrl, targetAspectRatio: _currentAspectRatio, onAspectRatioChanged: _updateLayoutForVideo)), Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_info(true), const SizedBox(height: 24), _over(), const Divider(color: Colors.white10, height: 48), const Text("Episodes", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 12), PlaylistSidebar(seasons: _mov.seasons, currentSeason: _sea, currentEpisode: _ep, onSeasonChanged: (s) => setState(() => _sea = s), onEpisodeTap: (e) => setState(() => _ep = e), isLoadingMore: false, onLoadMore: (){}), const SizedBox(height: 32), _recs()]))]));
  
  // �7�3 THE CERTIFIED DESKTOP LAYOUT WITH MATHEMATICAL PRECISION
  Widget _desk() {
    // 1. Calculate Flex based on Ratio (Elasticity)
    int playerFlex = _currentAspectRatio > 1.5 ? 7 : 5;
    int listFlex = _currentAspectRatio > 1.5 ? 3 : 5;

    return LayoutBuilder(builder: (context, constraints) {
      // 2. Calculate Exact Pixel Width/Height of Player
      double totalWidth = constraints.maxWidth - 48; // padding left+right
      double playerWidth = totalWidth * (playerFlex / (playerFlex + listFlex));
      double playerHeight = playerWidth / _currentAspectRatio;
      
      // 3. Subtract Ad Height (Approx 100px) + Padding to get Playlist max height
      double playlistMaxHeight = playerHeight - 140; 
      if (playlistMaxHeight < 200) playlistMaxHeight = 200; // Safety floor

      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // LEFT: Player + Info
                Expanded(flex: playerFlex, child: Column(children: [
                   SmartMediaKitPlayer(sources: _ep.sources, targetAspectRatio: _currentAspectRatio, onAspectRatioChanged: _updateLayoutForVideo),
                   const SizedBox(height: 20), 
                   _info(false)
                ])), 
                
                const SizedBox(width: 24), 
                
                // RIGHT: Playlist + Overview
                Expanded(flex: listFlex, child: Column(children: [
                  // Playlist height is now MATHEMATICALLY BOUND to Player Height
                  PlaylistSidebar(
                    isDesktop: true, 
                    maxHeight: playlistMaxHeight, // �7�3 PASSED EXACT HEIGHT
                    seasons: _mov.seasons, currentSeason: _sea, currentEpisode: _ep, onSeasonChanged: (s) => setState(() => _sea = s), onEpisodeTap: (e) => setState(() => _ep = e), isLoadingMore: false, onLoadMore: (){}
                  ),
                  const SizedBox(height: 24), 
                  _over() // Overview sits perfectly below the constrained playlist
                ]))
              ]),
            ),
            _recs()
          ],
        ),
      );
    });
  }

  Widget _info(bool mob) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(_mov.title, style: mob ? AppStyles.headlineMedium : AppStyles.headlineLarge), const SizedBox(height: 12), Row(children: [const Icon(Icons.star, color: Colors.amber, size: 18), const Text(" 9.8", style: TextStyle(color: Colors.greenAccent))]), const SizedBox(height: 20), SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [ActionIconButton(icon: Icons.add, label: "List", onTap: (){}), const SizedBox(width: 16), ActionIconButton(icon: Icons.share, label: "Share", onTap: (){}), const SizedBox(width: 16), ActionIconButton(icon: Icons.flag, label: "Report", onTap: (){}), const SizedBox(width: 16), ActionIconButton(icon: Icons.alarm, label: "Remind", onTap: (){})]))]);
  Widget _over() => Text(_mov.overview, style: const TextStyle(color: Colors.white70));
  Widget _recs() => LazyHorizontalSection(title: "Recommendations", initialMovies: List.generate(5, (i) => MovieSnippet(id: "$i", imageUrl: "https://via.placeholder.com/150x220", title: "Movie $i")), onLoadMore: () async => []);
}
