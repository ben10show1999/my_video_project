import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/components/expandable_text.dart'; // Task 9
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
    String url1 = "https://user-images.githubusercontent.com/28053651/202696586-48e7996a-7485-414f-8484-a5416297ea42.mp4"; 
    _mov = MovieModel(id: 1, title: "Flutter Mastery: The Complete Guide to Building Apps", overview: "This is a very long description intended to test the expandable text feature. It should show a few lines and then truncate with dots, allowing the user to click 'Show More' to reveal the entire content of the description. This ensures the layout remains clean.", posterPath: "", seasons: [
      SeasonModel(id: "s1", title: "Season 1", episodes: List.generate(5, (i) => EpisodeModel(id: "s1e$i", title: "S1 Ep ${i+1}", duration: "24:00", seasonNumber: 1, episodeNumber: i+1, sources: [VideoQualityModel(quality: "1080p", urls: [url1])]))),
    ]); 
    _sea = _mov.seasons.first; _ep = _sea.episodes.first; 
  }

  void _updateLayoutForVideo(double ratio) { if (mounted && _currentAspectRatio != ratio) setState(() => _currentAspectRatio = ratio); }

  @override Widget build(BuildContext context) { return Scaffold(backgroundColor: AppColors.background, body: LayoutBuilder(builder: (c, cs) => cs.maxWidth > 900 ? _desk() : _mob())); }
  
  Widget _mob() => SingleChildScrollView(controller: _sc, child: Column(children: [AspectRatio(aspectRatio: _currentAspectRatio, child: SmartMediaKitPlayer(sources: _ep.sources, thumbnailUrl: _ep.thumbnailUrl, targetAspectRatio: _currentAspectRatio, onAspectRatioChanged: _updateLayoutForVideo)), Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_info(true), const SizedBox(height: 24), _over(), const Divider(color: Colors.white10, height: 48), const Text("Episodes", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 12), PlaylistSidebar(seasons: _mov.seasons, currentSeason: _sea, currentEpisode: _ep, onSeasonChanged: (s) => setState(() => _sea = s), onEpisodeTap: (e) => setState(() => _ep = e), isLoadingMore: false, onLoadMore: (){}), const SizedBox(height: 32), _recs()]))]));
  
  // �7�3 Elastic Layout
  Widget _desk() {
    int playerFlex = _currentAspectRatio > 1.5 ? 7 : 5;
    int listFlex = _currentAspectRatio > 1.5 ? 3 : 5;
    return LayoutBuilder(builder: (context, constraints) {
      double totalWidth = constraints.maxWidth - 48;
      double playerWidth = totalWidth * (playerFlex / (playerFlex + listFlex));
      double playerHeight = playerWidth / _currentAspectRatio;
      double playlistMaxHeight = playerHeight - 140; 
      if (playlistMaxHeight < 200) playlistMaxHeight = 200; 

      return SingleChildScrollView(child: Column(children: [Padding(padding: const EdgeInsets.all(24), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(flex: playerFlex, child: Column(children: [SmartMediaKitPlayer(sources: _ep.sources, targetAspectRatio: _currentAspectRatio, onAspectRatioChanged: _updateLayoutForVideo), const SizedBox(height: 20), _info(false)])), const SizedBox(width: 24), Expanded(flex: listFlex, child: Column(children: [PlaylistSidebar(isDesktop: true, maxHeight: playlistMaxHeight, seasons: _mov.seasons, currentSeason: _sea, currentEpisode: _ep, onSeasonChanged: (s) => setState(() => _sea = s), onEpisodeTap: (e) => setState(() => _ep = e), isLoadingMore: false, onLoadMore: (){}), const SizedBox(height: 24), _over()]))])), _recs()]));
    });
  }

  // �7�3 Truncation & ExpandableText
  Widget _info(bool mob) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(_mov.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: mob ? AppStyles.headlineMedium : AppStyles.headlineLarge), const SizedBox(height: 12), Row(children: [const Icon(Icons.star, color: Colors.amber, size: 18), const Text(" 9.8", style: TextStyle(color: Colors.greenAccent))]), const SizedBox(height: 20), SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [ActionIconButton(icon: Icons.add, label: "List", onTap: (){}), const SizedBox(width: 16), ActionIconButton(icon: Icons.share, label: "Share", onTap: (){}), const SizedBox(width: 16), ActionIconButton(icon: Icons.flag, label: "Report", onTap: (){}), const SizedBox(width: 16), ActionIconButton(icon: Icons.alarm, label: "Remind", onTap: (){})]))]);
  Widget _over() => ExpandableText(text: _mov.overview);
  Widget _recs() => LazyHorizontalSection(title: "Recommendations", initialMovies: List.generate(5, (i) => MovieSnippet(id: "$i", imageUrl: "https://via.placeholder.com/150x220", title: "Movie $i")), onLoadMore: () async => []);
}
