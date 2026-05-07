import 'package:flutter/material.dart'; 
import 'package:my_video_project/core/components/universal_image.dart'; 
import 'package:my_video_project/core/theme/app_colors.dart'; 
import 'package:my_video_project/data/models/movie_models.dart'; 
import 'package:my_video_project/core/services/remote_config_service.dart'; 
import 'package:my_video_project/presentation/details/movie_details_screen.dart' deferred as details_page;

class ViewAllScreen extends StatelessWidget { 
  final String title; 
  final bool showTitles; 
  final List<MovieSnippet> movies; 
  
  const ViewAllScreen({super.key, required this.title, this.showTitles = true, required this.movies}); 
  
  @override Widget build(BuildContext context) { 
    return Scaffold(
      backgroundColor: AppColors.background, 
      appBar: AppBar(backgroundColor: Colors.transparent, title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), leading: const BackButton(color: Colors.white)), 
      body: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: LayoutBuilder(builder: (c, cs) { 
          int cnt = (cs.maxWidth / 150).floor().clamp(3, 8); 
          double itemW = (cs.maxWidth - (cnt - 1) * 16) / cnt; 
          double itemH = showTitles ? ((itemW * 1.5) + 65) : (itemW * 1.5); 
          double ratio = itemW / itemH; 
          
          return GridView.builder(
            padding: const EdgeInsets.only(bottom: 120), 
            itemCount: movies.length, 
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cnt, childAspectRatio: ratio, crossAxisSpacing: 16, mainAxisSpacing: 16
            ), 
            itemBuilder: (c, i) { 
              final m = movies[i]; 
              return InkWell(
                onTap: () async { 
                  if(RemoteConfigService.moviesDb.containsKey(m.id)) { 
                    await details_page.loadLibrary(); 
                    if(context.mounted) Navigator.push(context, MaterialPageRoute(builder: (_) => details_page.MovieDetailsScreen(movie: RemoteConfigService.moviesDb[m.id]!))); 
                  } 
                }, 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    ClipRRect(borderRadius: BorderRadius.circular(8), child: Container(color: const Color(0xFF1A1A1A), child: UniversalImage(path: m.imageUrl, fit: BoxFit.cover))), 
                    if(showTitles) const SizedBox(height: 8), 
                    if(showTitles) Text(m.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontSize: 13))
                  ]
                )
              ); 
            }
          ); 
        })
      )
    ); 
  } 
}
