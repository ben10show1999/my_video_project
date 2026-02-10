import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/presentation/components/ads/ads_system.dart';
import 'package:my_video_project/presentation/components/ads/web_ad_injector.dart';

class PlaylistSidebar extends StatefulWidget { 
  final List<SeasonModel> seasons; final SeasonModel currentSeason; final EpisodeModel currentEpisode; final Function(SeasonModel) onSeasonChanged; final Function(EpisodeModel) onEpisodeTap; 
  final bool isDesktop; final bool isLoadingMore; final VoidCallback onLoadMore; 
  const PlaylistSidebar({super.key, required this.seasons, required this.currentSeason, required this.currentEpisode, required this.onSeasonChanged, required this.onEpisodeTap, this.isDesktop = false, required this.isLoadingMore, required this.onLoadMore}); 
  @override State<PlaylistSidebar> createState() => _PlaylistSidebarState(); 
}
class _PlaylistSidebarState extends State<PlaylistSidebar> { 
  bool _ad = true; final ScrollController _sc = ScrollController(); 
  @override void initState() { super.initState(); if (widget.isDesktop) _sc.addListener(() { if (_sc.position.pixels >= _sc.position.maxScrollExtent * 0.9) widget.onLoadMore(); }); } 
  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context); 
    // Task 19: Re-using the same Ad Logic in Playlist
    final adCode = '<script>atOptions = {"key" : "ea534947875b8853a56110f9767a6a83", "format" : "iframe", "height" : 250, "width" : 300, "params" : {}};</script><script src="https://www.highperformanceformat.com/ea534947875b8853a56110f9767a6a83/invoke.js"></script>';

    return Container(decoration: BoxDecoration(color: const Color(0xFF1A1A1A), border: Border.all(color: Colors.white10), borderRadius: BorderRadius.circular(8)), child: Column(children: [Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white10))), child: Column(children: [DropdownButton<SeasonModel>(value: widget.currentSeason, dropdownColor: const Color(0xFF202020), isExpanded: true, items: widget.seasons.map((s) => DropdownMenuItem(value: s, child: Text(s.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)))).toList(), onChanged: (v) { if (v != null) widget.onSeasonChanged(v); }), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(p.tr('autoplay'), style: const TextStyle(color: Colors.grey)), Switch(value: p.isAutoplayEnabled, onChanged: (v) => p.toggleAutoplay(v), activeThumbColor: Colors.amber)])])), 
    if (_ad) Padding(padding: const EdgeInsets.all(8.0), child: SmartAdContainer(aspectRatio: 3, onClose: () => setState(() => _ad = false), child: WebAdInjector(scriptContent: adCode))), 
    Expanded(child: _list())])); } 
  Widget _list() => ListView.builder(controller: widget.isDesktop ? _sc : null, shrinkWrap: !widget.isDesktop, padding: const EdgeInsets.only(bottom: 120), physics: widget.isDesktop ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(), itemCount: widget.currentSeason.episodes.length + (widget.isLoadingMore ? 1 : 0), itemBuilder: (c, i) { if (i == widget.currentSeason.episodes.length) return const Center(child: CircularProgressIndicator(color: Colors.amber)); final e = widget.currentSeason.episodes[i]; final sel = e.id == widget.currentEpisode.id; return InkWell(onTap: () => widget.onEpisodeTap(e), child: Container(padding: const EdgeInsets.all(8), color: sel ? Colors.white10 : Colors.transparent, child: Row(children: [SizedBox(width: 100, height: 60, child: UniversalImage(path: e.thumbnailUrl ?? "")), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(e.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: sel ? Colors.amber : Colors.white)), Text(e.duration, style: const TextStyle(color: Colors.grey, fontSize: 12))]))]))); }); 
}
