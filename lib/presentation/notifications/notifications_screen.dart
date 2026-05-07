import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart'; 
import 'package:my_video_project/core/logic/app_provider.dart'; 
import 'package:my_video_project/core/theme/app_colors.dart'; 
import 'package:my_video_project/core/components/universal_image.dart'; 
import 'package:my_video_project/core/services/remote_config_service.dart'; 
import 'package:my_video_project/presentation/details/movie_details_screen.dart' deferred as details_page;

class NotificationsScreen extends StatelessWidget { 
  const NotificationsScreen({super.key}); 
  
  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context); 
    final notifs = p.activeNotifications;
    
    return Scaffold(
      backgroundColor: AppColors.background, 
      appBar: AppBar(
        title: Text(p.tr('notifications')), 
        centerTitle: true, 
        leading: const BackButton(color: Colors.white), 
        backgroundColor: Colors.transparent
      ), 
      body: !p.notificationsEnabled 
        ? const Center(child: Text("Disabled", style: TextStyle(color: Colors.grey))) 
        : (notifs.isEmpty 
            ? Center(child: Text(p.tr('empty_notifs'), style: const TextStyle(color: Colors.grey))) 
            : ListView.separated(
                padding: const EdgeInsets.all(16), 
                itemCount: notifs.length, 
                separatorBuilder: (_,__) => const SizedBox(height: 12), 
                itemBuilder: (c, i) { 
                  final n = notifs[i]; 
                  return InkWell(
                    onTap: () async { 
                      if (n.targetId != null && RemoteConfigService.moviesDb.containsKey(n.targetId)) { 
                        await details_page.loadLibrary(); 
                        if(context.mounted) {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => details_page.MovieDetailsScreen(movie: RemoteConfigService.moviesDb[n.targetId]!))); 
                        }
                      } 
                    }, 
                    child: Container(
                      padding: const EdgeInsets.all(8), 
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A), 
                        border: Border.all(color: Colors.white10), 
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100, 
                            height: 60, 
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4), 
                              child: UniversalImage(path: n.imageUrl ?? "https://iili.io/q2Ty8N4.webp", fit: BoxFit.cover)
                            )
                          ), 
                          const SizedBox(width: 10), 
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, 
                              children: [
                                Text(n.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), 
                                Text(n.body, style: const TextStyle(color: Colors.grey, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis)
                              ]
                            )
                          ),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert, color: Colors.white54), 
                            color: const Color(0xFF202020),
                            onSelected: (v) { 
                              if (v == 'delete') p.deleteNotification(n.id); 
                            },
                            itemBuilder: (c) => [
                              PopupMenuItem(
                                value: 'delete', 
                                child: Row(
                                  children: [
                                    const Icon(Icons.delete, color: Colors.redAccent, size: 20), 
                                    const SizedBox(width: 8), 
                                    Text(p.tr('delete'), style: const TextStyle(color: Colors.white))
                                  ]
                                )
                              )
                            ]
                          )
                        ]
                      )
                    )
                  ); 
                }
              )
          )
    ); 
  } 
}
