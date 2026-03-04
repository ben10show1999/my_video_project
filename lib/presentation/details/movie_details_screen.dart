import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
import 'package:my_video_project/core/theme/app_styles.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/utils/thumbnail_cache.dart';
import 'package:my_video_project/core/components/expandable_text.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/data/mock_data.dart';
import 'package:my_video_project/presentation/components/buttons/action_icon_button.dart';
import 'package:my_video_project/presentation/components/player/smart_media_kit_player.dart';
import 'package:my_video_project/presentation/details/components/playlist_sidebar.dart';
import 'package:my_video_project/presentation/details/components/lazy_horizontal_section.dart';

class MovieDetailsScreen extends StatefulWidget { final MovieModel movie; const MovieDetailsScreen({super.key, required this.movie}); @override State<MovieDetailsScreen> createState() => _MovieDetailsScreenState(); }
class _MovieDetailsScreenState extends State<MovieDetailsScreen> { 
  late ScrollController _sc; late SeasonModel _sea; late EpisodeModel _ep; double _currentAspectRatio = 16/9; 
  final GlobalKey _playerKey = GlobalKey(); bool _isFullscreen = false;
  @override void initState() { super.initState(); _sc = ScrollController(); _sea = widget.movie.seasons.isNotEmpty ? widget.movie.seasons.first : SeasonModel(id: '0', title: 'No Seasons', episodes: []); _ep = _sea.episodes.isNotEmpty ? _sea.episodes.first : EpisodeModel(id: '0', title: 'No Episode', duration: '', seasonNumber: 0, episodeNumber: 0, sources: []); } 
  @override void dispose() { ThumbnailCache.abortAll(); _sc.dispose(); super.dispose(); }
  void _updateLayoutForVideo(double ratio) { if (mounted && (_currentAspectRatio - ratio).abs() > 0.01) setState(() => _currentAspectRatio = ratio); }
  Widget _buildPlayerInstance() { return SmartMediaKitPlayer(key: _playerKey, movieId: widget.movie.id.toString(), movieTitle: widget.movie.title, sources: _ep.sources, thumbnailUrl: _ep.thumbnailUrl, onAspectRatioChanged: _updateLayoutForVideo, isFullscreen: _isFullscreen, onFullscreenToggle: () => setState(() => _isFullscreen = !_isFullscreen)); }

  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context); 
    return Scaffold(
      backgroundColor: AppColors.background, 
      appBar: _isFullscreen ? null : AppBar(title: Text(p.tr('watch')), centerTitle: true, leading: const BackButton(color: Colors.white)), 
      body: Stack(children: [ LayoutBuilder(builder: (c, cs) => cs.maxWidth > 900 ? _desk(p) : _mob(p)), if (_isFullscreen) Positioned.fill(child: Container(color: Colors.black, child: Center(child: AspectRatio(aspectRatio: _currentAspectRatio, child: _buildPlayerInstance())))) ])
    ); 
  }
  
  Widget _mob(AppProvider p) => SingleChildScrollView(controller: _sc, child: Column(children: [ if (_isFullscreen) AspectRatio(aspectRatio: _currentAspectRatio, child: Container(color: Colors.black)) else AspectRatio(aspectRatio: _currentAspectRatio, child: _buildPlayerInstance()), Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_info(true, p), const SizedBox(height: 24), ExpandableText(text: widget.movie.overview), const Divider(color: Colors.white10, height: 48), Text(p.tr('episodes'), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 12), SizedBox(height: 400, child: PlaylistSidebar(seasons: widget.movie.seasons, currentSeason: _sea, currentEpisode: _ep, onSeasonChanged: (s) => setState(() => _sea = s), onEpisodeTap: (e) => setState(() => _ep = e), isLoadingMore: false, onLoadMore: (){})), const SizedBox(height: 32), LazyHorizontalSection(title: p.tr('recommendations'), initialMovies: MockData.allMovies.take(5).map((m) => MovieSnippet(id: m.id.toString(), imageUrl: m.posterPath, title: m.title)).toList(), onLoadMore: () async => [])]))]));
  Widget _desk(AppProvider p) { return LayoutBuilder(builder: (context, constraints) { double availableWidth = constraints.maxWidth - 48; double playerWidthShare = _currentAspectRatio >= 1.7 ? 0.68 : (_currentAspectRatio < 1.0 ? 0.40 : 0.55); double playerWidth = availableWidth * playerWidthShare; double playerHeight = playerWidth / _currentAspectRatio; double listWidth = availableWidth - playerWidth - 24; return SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(24), child: Column(children: [Row(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(width: playerWidth, child: Column(children: [ if (_isFullscreen) SizedBox(height: playerHeight, child: Container(color: Colors.black)) else SizedBox(height: playerHeight, child: _buildPlayerInstance()), const SizedBox(height: 20), _info(false, p)])), const SizedBox(width: 24), SizedBox(width: listWidth, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(height: playerHeight, child: PlaylistSidebar(isDesktop: true, seasons: widget.movie.seasons, currentSeason: _sea, currentEpisode: _ep, onSeasonChanged: (s) => setState(() => _sea = s), onEpisodeTap: (e) => setState(() => _ep = e), isLoadingMore: false, onLoadMore: (){})), const SizedBox(height: 20), Text(p.tr('overview'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(height: 8), ExpandableText(text: widget.movie.overview)]))]), const SizedBox(height: 40), LazyHorizontalSection(title: p.tr('recommendations'), initialMovies: MockData.allMovies.take(5).map((m) => MovieSnippet(id: m.id.toString(), imageUrl: m.posterPath, title: m.title)).toList(), onLoadMore: () async => [])]))); }); }
  Widget _info(bool mob, AppProvider p) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.movie.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: mob ? AppStyles.headlineMedium : AppStyles.headlineLarge), const SizedBox(height: 12), Row(children: [const Icon(Icons.star, color: Colors.amber, size: 18), const Text(" 9.8", style: TextStyle(color: Colors.greenAccent)), const SizedBox(width: 12), const Text("2024", style: TextStyle(color: Colors.white70))]), const SizedBox(height: 20), SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [ActionIconButton(icon: p.isInList(widget.movie.id) ? Icons.check : Icons.add, label: "List", isActive: p.isInList(widget.movie.id), onTap: () { p.toggleMyList(widget.movie.id); }), const SizedBox(width: 16), ActionIconButton(icon: Icons.share, label: "Share", onTap: (){})]))]);
}
