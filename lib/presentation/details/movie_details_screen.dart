import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/components/expandable_text.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/presentation/components/buttons/action_icon_button.dart';
import 'package:my_video_project/presentation/components/player/smart_media_kit_player.dart';
import 'package:my_video_project/presentation/details/components/playlist_sidebar.dart';

class MovieDetailsScreen extends StatefulWidget { final MovieModel movie; const MovieDetailsScreen({super.key, required this.movie}); @override State<MovieDetailsScreen> createState() => _MovieDetailsScreenState(); }
class _MovieDetailsScreenState extends State<MovieDetailsScreen> { 
  late SeasonModel _sea; late EpisodeModel _ep; double _currentAspectRatio = 16/9; 
  @override void initState() { super.initState(); _sea = widget.movie.seasons.first; _ep = _sea.episodes.first; } 
  
  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context); 
    return Scaffold(
      backgroundColor: Colors.black, 
      appBar: AppBar(backgroundColor: Colors.transparent, leading: const BackButton(color: Colors.white)), 
      body: LayoutBuilder(builder: (c, cs) => cs.maxWidth > 900 ? _desk(p) : _mob(p))
    ); 
  }
  
  // Task 32: Desktop Layout with explicit Description placement
  Widget _desk(AppProvider p) { 
    return LayoutBuilder(builder: (context, constraints) { 
      double playerHeight = (constraints.maxWidth * 0.7) / _currentAspectRatio;
      return SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(flex: 7, child: SmartMediaKitPlayer(sources: _ep.sources, onAspectRatioChanged: (r) => setState(() => _currentAspectRatio = r))),
          const SizedBox(width: 20),
          Expanded(flex: 3, child: SizedBox(height: playerHeight, child: PlaylistSidebar(currentSeason: _sea, currentEpisode: _ep, onEpisodeTap: (e) => setState(() => _ep = e), isDesktop: true)))
        ]),
        const SizedBox(height: 24),
        Text(widget.movie.title, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(children: [ActionIconButton(icon: Icons.add, label: "List", onTap: (){}), ActionIconButton(icon: Icons.flag, label: "Report", onTap: (){})]),
        const SizedBox(height: 12),
        Text("Overview", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ExpandableText(text: widget.movie.overview, maxLines: 5), // Full text logic
        const SizedBox(height: 50),
      ]))); 
    }); 
  }
  
  Widget _mob(AppProvider p) => SingleChildScrollView(child: Column(children: [
    AspectRatio(aspectRatio: _currentAspectRatio, child: SmartMediaKitPlayer(sources: _ep.sources, onAspectRatioChanged: (r) => setState(() => _currentAspectRatio = r))), 
    Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
       Text(widget.movie.title, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
       const SizedBox(height: 12),
       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [ActionIconButton(icon: Icons.add, label: "List", onTap: (){}), ActionIconButton(icon: Icons.flag, label: "Report", onTap: (){})]),
       const SizedBox(height: 16),
       const Text("Overview", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
       const SizedBox(height: 8),
       ExpandableText(text: widget.movie.overview, maxLines: 3), 
       const Divider(color: Colors.white10, height: 30),
       PlaylistSidebar(currentSeason: _sea, currentEpisode: _ep, onEpisodeTap: (e) => setState(() => _ep = e))
    ]))
  ]));
}
