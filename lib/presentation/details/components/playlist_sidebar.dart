import 'package:flutter/material.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/data/models/movie_models.dart';

class PlaylistSidebar extends StatelessWidget { 
  final SeasonModel currentSeason; final EpisodeModel currentEpisode; final Function(EpisodeModel) onEpisodeTap; final bool isDesktop;
  const PlaylistSidebar({super.key, required this.currentSeason, required this.currentEpisode, required this.onEpisodeTap, this.isDesktop = false}); 
  @override Widget build(BuildContext context) { 
    return Container(
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), border: Border.all(color: Colors.white10), borderRadius: BorderRadius.circular(8)), 
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemCount: currentSeason.episodes.length, 
        itemBuilder: (c, i) { 
          final e = currentSeason.episodes[i]; 
          final sel = e.id == currentEpisode.id; 
          return InkWell(onTap: () => onEpisodeTap(e), child: Container(padding: const EdgeInsets.all(8), color: sel ? Colors.white10 : Colors.transparent, child: Row(children: [
            SizedBox(width: 100, height: 60, child: UniversalImage(path: e.thumbnailUrl ?? "")), 
            const SizedBox(width: 10), 
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(e.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: sel ? Colors.amber : Colors.white)), 
              Text(e.duration, style: const TextStyle(color: Colors.grey, fontSize: 12))
            ]))
          ]))); 
        }
      )
    ); 
  } 
}
