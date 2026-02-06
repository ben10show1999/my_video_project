import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
import 'package:my_video_project/core/theme/app_styles.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
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
  @override void initState() { super.initState(); _sc = ScrollController(); _sea = widget.movie.seasons.isNotEmpty ? widget.movie.seasons.first : SeasonModel(id: '0', title: 'No Seasons', episodes: []); _ep = _sea.episodes.isNotEmpty ? _sea.episodes.first : EpisodeModel(id: '0', title: 'No Episode', duration: '', seasonNumber: 0, episodeNumber: 0, sources: []); } 
  void _updateLayoutForVideo(double ratio) { if (mounted && (_currentAspectRatio - ratio).abs() > 0.01) setState(() => _currentAspectRatio = ratio); }

  void _showInfoDialog(BuildContext context, AppProvider p) {
    showDialog(context: context, builder: (c) => AlertDialog(
      backgroundColor: const Color(0xFF202020),
      title: Center(child: Text(p.tr('content_note'), style: const TextStyle(color: Colors.white))),
      content: Text(p.tr('content_desc'), style: const TextStyle(color: Colors.white70), textAlign: TextAlign.center),
      actions: [TextButton(onPressed: () => Navigator.pop(c), child: Text(p.tr('close')))]
    ));
  }
  
  // Task 18: Report Logic
  Future<void> _handleReport(AppProvider p) async {
    final Uri emailLaunchUri = Uri(scheme: 'mailto', path: 'support@example.com', queryParameters: {'subject': '${p.tr('report_subject')} ${widget.movie.title} (ID: ${widget.movie.id})'});
    if (await canLaunchUrl(emailLaunchUri)) await launchUrl(emailLaunchUri);
  }

  // Task 17: Remind Logic
  void _handleRemind(BuildContext context, AppProvider p) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(p.tr('reminder_set')), backgroundColor: AppColors.success));
  }

  // Task 20: List Logic
  void _handleList(BuildContext context, AppProvider p) {
    p.toggleMyList(widget.movie.id);
    final msg = p.isInList(widget.movie.id) ? p.tr('added_list') : p.tr('removed_list');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: AppColors.primary));
  }

  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(p.tr('watch')), centerTitle: true, 
        backgroundColor: Colors.transparent, elevation: 0,
        leading: const BackButton(color: Colors.white),
        actions: [IconButton(icon: const Icon(Icons.info_outline, color: Colors.white), onPressed: () => _showInfoDialog(context, p)), const SizedBox(width: 8)],
      ),
      body: LayoutBuilder(builder: (c, cs) => cs.maxWidth > 900 ? _desk(p) : _mob(p))
    ); 
  }
  
  Widget _mob(AppProvider p) => SingleChildScrollView(controller: _sc, child: Column(children: [AspectRatio(aspectRatio: _currentAspectRatio, child: SmartMediaKitPlayer(sources: _ep.sources, thumbnailUrl: _ep.thumbnailUrl, onAspectRatioChanged: _updateLayoutForVideo)), Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_info(true, p), const SizedBox(height: 24), _over(), const Divider(color: Colors.white10, height: 48), Text(p.tr('episodes'), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 12), PlaylistSidebar(seasons: widget.movie.seasons, currentSeason: _sea, currentEpisode: _ep, onSeasonChanged: (s) => setState(() => _sea = s), onEpisodeTap: (e) => setState(() => _ep = e), isLoadingMore: false, onLoadMore: (){}), const SizedBox(height: 32), _recs(p)]))]));
  Widget _desk(AppProvider p) { return LayoutBuilder(builder: (context, constraints) { double availableWidth = constraints.maxWidth - 48; double playerWidthShare = _currentAspectRatio < 1.0 ? 0.45 : 0.65; double playerWidth = availableWidth * playerWidthShare; double playerHeight = playerWidth / _currentAspectRatio; double listWidth = availableWidth - playerWidth - 24; return SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(24), child: Column(children: [Row(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(width: playerWidth, child: Column(children: [SizedBox(height: playerHeight, child: SmartMediaKitPlayer(sources: _ep.sources, onAspectRatioChanged: _updateLayoutForVideo)), const SizedBox(height: 20), _info(false, p)])), const SizedBox(width: 24), SizedBox(width: listWidth, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(height: playerHeight, child: PlaylistSidebar(isDesktop: true, seasons: widget.movie.seasons, currentSeason: _sea, currentEpisode: _ep, onSeasonChanged: (s) => setState(() => _sea = s), onEpisodeTap: (e) => setState(() => _ep = e), isLoadingMore: false, onLoadMore: (){})), const SizedBox(height: 20), Text(p.tr('overview'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(height: 8), _over()]))]), const SizedBox(height: 40), _recs(p)]))); }); }
  
  Widget _info(bool mob, AppProvider p) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(widget.movie.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: mob ? AppStyles.headlineMedium : AppStyles.headlineLarge), 
    const SizedBox(height: 12), 
    // Task 19: Restored Metadata (Year, PG-13, Rating)
    Row(children: [
      const Icon(Icons.star, color: Colors.amber, size: 18), 
      const Text(" 9.8", style: TextStyle(color: Colors.greenAccent)),
      const SizedBox(width: 12),
      const Text("2024", style: TextStyle(color: Colors.white70)),
      const SizedBox(width: 12),
      Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppColors.badgeBg, borderRadius: BorderRadius.circular(4)), child: const Text("PG-13", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))
    ]), 
    const SizedBox(height: 20), 
    SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
      ActionIconButton(icon: p.isInList(widget.movie.id) ? Icons.check : Icons.add, label: "List", isActive: p.isInList(widget.movie.id), onTap: () => _handleList(context, p)), 
      const SizedBox(width: 16), 
      ActionIconButton(icon: Icons.share, label: "Share", onTap: (){}), 
      const SizedBox(width: 16), 
      ActionIconButton(icon: Icons.flag, label: "Report", onTap: () => _handleReport(p)), 
      const SizedBox(width: 16), 
      ActionIconButton(icon: Icons.alarm, label: "Remind", onTap: () => _handleRemind(context, p))
    ]))
  ]);
  Widget _over() => ExpandableText(text: widget.movie.overview);
  Widget _recs(AppProvider p) => LazyHorizontalSection(title: p.tr('recommendations'), initialMovies: MockData.allMovies.take(5).map((m) => MovieSnippet(id: m.id.toString(), imageUrl: m.posterPath, title: m.title)).toList(), onLoadMore: () async => []);
}
