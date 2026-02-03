import 'package:flutter/material.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
import 'package:my_video_project/core/theme/app_styles.dart';
import 'package:my_video_project/core/components/expandable_text.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/data/mock_data.dart';
import 'package:my_video_project/presentation/components/buttons/action_icon_button.dart';
import 'package:my_video_project/presentation/components/player/smart_media_kit_player.dart';
import 'package:my_video_project/presentation/details/components/playlist_sidebar.dart';
import 'package:my_video_project/presentation/details/components/lazy_horizontal_section.dart';

class MovieDetailsScreen extends StatefulWidget { final MovieModel movie; const MovieDetailsScreen({super.key, required this.movie}); @override State<MovieDetailsScreen> createState() => _MovieDetailsScreenState(); }
class _MovieDetailsScreenState extends State<MovieDetailsScreen> { 
  late ScrollController _sc; late SeasonModel _sea; late EpisodeModel _ep; 
  double _currentAspectRatio = 16/9; 

  @override void initState() { super.initState(); _sc = ScrollController(); _sea = widget.movie.seasons.isNotEmpty ? widget.movie.seasons.first : SeasonModel(id: '0', title: 'No Seasons', episodes: []); _ep = _sea.episodes.isNotEmpty ? _sea.episodes.first : EpisodeModel(id: '0', title: 'No Episode', duration: '', seasonNumber: 0, episodeNumber: 0, sources: []); } 
  
  void _updateLayoutForVideo(double ratio) { if (mounted && (_currentAspectRatio - ratio).abs() > 0.01) setState(() => _currentAspectRatio = ratio); }

  @override Widget build(BuildContext context) { return Scaffold(backgroundColor: AppColors.background, body: LayoutBuilder(builder: (c, cs) => cs.maxWidth > 900 ? _desk() : _mob())); }
  
  Widget _mob() => SingleChildScrollView(controller: _sc, child: Column(children: [AspectRatio(aspectRatio: _currentAspectRatio, child: SmartMediaKitPlayer(sources: _ep.sources, thumbnailUrl: _ep.thumbnailUrl, onAspectRatioChanged: _updateLayoutForVideo)), Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_info(true), const SizedBox(height: 24), _over(), const Divider(color: Colors.white10, height: 48), const Text("Episodes", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 12), PlaylistSidebar(seasons: widget.movie.seasons, currentSeason: _sea, currentEpisode: _ep, onSeasonChanged: (s) => setState(() => _sea = s), onEpisodeTap: (e) => setState(() => _ep = e), isLoadingMore: false, onLoadMore: (){}), const SizedBox(height: 32), _recs()]))]));
  
  // �7�3 The Geometric Masterpiece: Coupled Heights & Dynamic Widths
  Widget _desk() {
    return LayoutBuilder(builder: (context, constraints) {
      double availableWidth = constraints.maxWidth - 48; // Padding
      
      // Dynamic Width Calculation
      // 0.45 width for tall videos, 0.65 width for wide videos
      double playerWidthShare = _currentAspectRatio < 1.0 ? 0.45 : 0.65;
      
      double playerWidth = availableWidth * playerWidthShare;
      double playerHeight = playerWidth / _currentAspectRatio; // The anchor height
      
      double listWidth = availableWidth - playerWidth - 24; // Fill remaining space
      
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  // Left Block (Player + Info)
                  SizedBox(
                    width: playerWidth,
                    child: Column(
                      children: [
                         SizedBox(height: playerHeight, child: SmartMediaKitPlayer(sources: _ep.sources, onAspectRatioChanged: _updateLayoutForVideo)),
                         const SizedBox(height: 20), // Vertical Rhythm Sync
                         _info(false)
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 24), 
                  
                  // Right Block (Playlist + Overview)
                  SizedBox(
                    width: listWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [
                        // Explicitly coupling height to player height
                        SizedBox(height: playerHeight, child: PlaylistSidebar(isDesktop: true, seasons: widget.movie.seasons, currentSeason: _sea, currentEpisode: _ep, onSeasonChanged: (s) => setState(() => _sea = s), onEpisodeTap: (e) => setState(() => _ep = e), isLoadingMore: false, onLoadMore: (){})),
                        const SizedBox(height: 20), // Vertical Rhythm Sync
                        const Text("Overview", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        _over()
                      ],
                    ),
                  )
                ]
              ),
              const SizedBox(height: 40),
              _recs()
            ],
          ),
        ),
      );
    });
  }

  Widget _info(bool mob) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.movie.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: mob ? AppStyles.headlineMedium : AppStyles.headlineLarge), const SizedBox(height: 12), Row(children: [const Icon(Icons.star, color: Colors.amber, size: 18), const Text(" 9.8", style: TextStyle(color: Colors.greenAccent))]), const SizedBox(height: 20), SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [ActionIconButton(icon: Icons.add, label: "List", onTap: (){}), const SizedBox(width: 16), ActionIconButton(icon: Icons.share, label: "Share", onTap: (){}), const SizedBox(width: 16), ActionIconButton(icon: Icons.flag, label: "Report", onTap: (){}), const SizedBox(width: 16), ActionIconButton(icon: Icons.alarm, label: "Remind", onTap: (){})]))]);
  Widget _over() => ExpandableText(text: widget.movie.overview);
  Widget _recs() => LazyHorizontalSection(title: "Recommendations", initialMovies: MockData.allMovies.take(5).map((m) => MovieSnippet(id: m.id.toString(), imageUrl: m.posterPath, title: m.title)).toList(), onLoadMore: () async => []);
}
