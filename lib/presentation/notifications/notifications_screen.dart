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
    final manager = Provider.of<AppProvider>(context); 
    return Scaffold(
      backgroundColor: AppColors.background, 
      appBar: AppBar(title: Text(manager.tr('notifications')), centerTitle: true, leading: const BackButton(color: Colors.white), backgroundColor: Colors.transparent), 
      body: !manager.notificationsEnabled 
        ? const Center(child: Text("Disabled", style: TextStyle(color: Colors.grey))) 
        : (manager.notifications.isEmpty 
          ? const Center(child: Text("No notifications", style: TextStyle(color: Colors.grey))) 
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 120),
              itemCount: manager.notifications.length, 
              itemBuilder: (c, i) { 
                final n = manager.notifications[i]; 
                return InkWell(
                  onTap: () async { 
                    if (n.targetId != null && RemoteConfigService.moviesDb.containsKey(n.targetId)) { 
                      await details_page.loadLibrary(); 
                      if(context.mounted) Navigator.push(context, MaterialPageRoute(builder: (_) => details_page.MovieDetailsScreen(movie: RemoteConfigService.moviesDb[n.targetId]!))); 
                    } 
                  }, 
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white10))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Task 41: Playlist-style Thumbnail
                        SizedBox(
                          width: 100, height: 60, 
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6), 
                            child: n.imageUrl != null 
                              ? Container(color: const Color(0xFF1A1A1A), child: UniversalImage(path: n.imageUrl!, fit: BoxFit.cover)) 
                              : Container(color: Colors.white10, child: const Icon(Icons.notifications, color: AppColors.primary))
                          )
                        ), 
                        const SizedBox(width: 12),
                        // Texts
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(n.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)), 
                              const SizedBox(height: 4),
                              Text(n.body, style: const TextStyle(color: Colors.grey, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis), 
                            ]
                          )
                        ),
                        // Task 42: Deletion Menu (The 3 Dots)
                        PopupMenuButton<String>(
                          color: const Color(0xFF202020),
                          icon: const Icon(Icons.more_vert, color: Colors.white54, size: 20),
                          itemBuilder: (context) => [
                            PopupMenuItem(value: 'delete', child: Text(manager.tr('delete'), style: const TextStyle(color: Colors.redAccent)))
                          ],
                          onSelected: (val) {
                            if (val == 'delete') { manager.deleteNotification(n.id); }
                          },
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
