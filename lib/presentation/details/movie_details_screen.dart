import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_styles.dart';
import '../../core/utils/security_utils.dart';
import '../../core/logic/app_provider.dart';
import '../../data/models/movie_models.dart';
import '../components/buttons/action_icon_button.dart';
import '../components/player/smart_media_kit_player.dart';
import 'components/playlist_sidebar.dart';
import 'components/lazy_horizontal_section.dart';

class MovieDetailsScreen extends StatefulWidget { const MovieDetailsScreen({super.key}); @override State<MovieDetailsScreen> createState() => _MovieDetailsScreenState(); }
class _MovieDetailsScreenState extends State<MovieDetailsScreen> { late ScrollController _sc; late MovieModel _mov; late SeasonModel _sea; late EpisodeModel _ep; @override void initState() { super.initState(); _sc = ScrollController(); _data(); } 
  
  void _data() { 
    String url1 = "https://user-images.githubusercontent.com/28053651/202696586-48e7996a-7485-414f-8484-a5416297ea42.mp4";
    String url2 = "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4"; 
    _mov = MovieModel(id: 1, title: "Flutter Mastery", overview: "This is a detailed overview of the show, placed correctly on desktop.", posterPath: "", seasons: [
      SeasonModel(id: "s1", title: "Season 1", episodes: List.generate(10, (i) => EpisodeModel(id: "$i", title: "Ep ${i+1}", duration: "24:00", seasonNumber: 1, episodeNumber: i+1, sources: [VideoQualityModel(quality: "1080p", urls: [url1, url1]), VideoQualityModel(quality: "720p", urls: [url2])]))),
      SeasonModel(id: "s2", title: "Season 2", episodes: List.generate(5, (i) => EpisodeModel(id: "s2_$i", title: "S2 Ep ${i+1}", duration: "45:00", seasonNumber: 2, episodeNumber: i+1, sources: [VideoQualityModel(quality: "1080p", urls: [url1])])))
    ]); 
    _sea = _mov.seasons.first; _ep = _sea.episodes.first; 
  }

  void _reportIssue() async { final Uri emailLaunchUri = Uri(scheme: 'mailto', path: 'support@myapp.com', query: 'subject=Report: ${_mov.title}&body=Ep: ${_ep.title}'); if (await canLaunchUrl(emailLaunchUri)) launchUrl(emailLaunchUri); } void _shareContent() { String link = SecurityUtils.generateDeepLink(_ep.id); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Link copied: $link"))); } void _remindMe() { Provider.of<AppProvider>(context, listen: false).scheduleReminder(_mov.title); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Reminder set!"))); }
  
  @override Widget build(BuildContext context) { return Scaffold(backgroundColor: AppColors.background, body: LayoutBuilder(builder: (c, cs) => cs.maxWidth > 900 ? _desk() : _mob())); }
  
  Widget _mob() => SingleChildScrollView(controller: _sc, child: Column(children: [SmartMediaKitPlayer(sources: _ep.sources, thumbnailUrl: _ep.thumbnailUrl), Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_info(true), const SizedBox(height: 24), _over(), const Divider(color: Colors.white10, height: 48), const Text("Episodes", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 12), PlaylistSidebar(seasons: _mov.seasons, currentSeason: _sea, currentEpisode: _ep, onSeasonChanged: (s) => setState(() => _sea = s), onEpisodeTap: (e) => setState(() => _ep = e), isLoadingMore: false, onLoadMore: (){}), const SizedBox(height: 32), _recs()]))]));

  // �7�3 FIXED DESKTOP LAYOUT: Main Column > (Row[Left|Right]) + Bottom Recs
  Widget _desk() => SingleChildScrollView(
    padding: const EdgeInsets.all(32), 
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column: Player + Info
            Expanded(flex: 3, child: Column(children: [SmartMediaKitPlayer(sources: _ep.sources), const SizedBox(height: 20), _info(false)])),
            const SizedBox(width: 32),
            // Right Column: Playlist + Overview
            Expanded(flex: 1, child: Column(children: [
              PlaylistSidebar(isDesktop: true, seasons: _mov.seasons, currentSeason: _sea, currentEpisode: _ep, onSeasonChanged: (s) => setState(() => _sea = s), onEpisodeTap: (e) => setState(() => _ep = e), isLoadingMore: false, onLoadMore: (){}), 
              const SizedBox(height: 24), 
              _over()
            ]))
          ]
        ),
        const SizedBox(height: 48),
        _recs()
      ],
    )
  );

  Widget _info(bool mob) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(_mov.title, style: mob ? AppStyles.headlineMedium : AppStyles.headlineLarge), const SizedBox(height: 12), Row(children: [const Icon(Icons.star, color: Colors.amber, size: 18), const Text(" 9.8", style: TextStyle(color: Colors.greenAccent)), const SizedBox(width: 16), Text(_ep.title, style: const TextStyle(color: Colors.white70, fontSize: 16))]), const SizedBox(height: 20), SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [ActionIconButton(icon: Icons.add, label: "List", onTap: (){}), const SizedBox(width: 16), ActionIconButton(icon: Icons.share, label: "Share", onTap: _shareContent), const SizedBox(width: 16), ActionIconButton(icon: Icons.flag, label: "Report", onTap: _reportIssue), const SizedBox(width: 16), ActionIconButton(icon: Icons.alarm, label: "Remind", onTap: _remindMe)]))]);
  Widget _over() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("Overview", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)), const SizedBox(height: 8), Text(_mov.overview, style: const TextStyle(color: Colors.white70))]);
  Widget _recs() => LazyHorizontalSection(title: "Recommendations", initialMovies: List.generate(5, (i) => MovieSnippet(id: "$i", imageUrl: "https://via.placeholder.com/150x220", title: "Movie $i")), onLoadMore: () async => []);
}
