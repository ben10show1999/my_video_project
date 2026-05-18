import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/core/services/remote_config_service.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/presentation/details/movie_details_screen.dart' deferred as details_page;

class NotificationsScreen extends StatelessWidget { 
  const NotificationsScreen({super.key}); 
  
  @override Widget build(BuildContext context) { 
    final manager = Provider.of<AppProvider>(context); 
    
    return Scaffold(
      backgroundColor: AppColors.background, 
      appBar: AppBar(title: Text(manager.tr('notifications')), centerTitle: true, leading: const BackButton(color: Colors.white), backgroundColor: Colors.transparent), 
      body: !manager.notificationsEnabled 
        ? Center(child: Text(manager.tr('disable'), style: const TextStyle(color: Colors.grey))) 
        : StreamBuilder<QuerySnapshot>(
            // 💡 الإرسال والحذف الفوري: الاستماع المباشر لمجموعة Firestore بدون أي وسيط
            stream: FirebaseFirestore.instance.collection('notifications').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: AppColors.primary));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No notifications", style: TextStyle(color: Colors.grey)));
              }
              
              // تحويل وثائق Firestore إلى كائنات برمجية مع تصفية المحذوف محلياً
              final allNotifs = snapshot.data!.docs.map((doc) {
                return AppNotification.fromJson(doc.data() as Map<String, dynamic>, doc.id);
              }).where((n) => !manager.isNotificationDeleted(n.id)).toList();

              if (allNotifs.isEmpty) {
                return const Center(child: Text("No notifications", style: TextStyle(color: Colors.grey)));
              }

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 120, top: 16), 
                itemCount: allNotifs.length, 
                itemBuilder: (c, i) { 
                  final n = allNotifs[i]; 
                  return InkWell(
                    onTap: () async { 
                      if (n.targetId != null && RemoteConfigService.moviesDb.containsKey(n.targetId)) { 
                        await details_page.loadLibrary(); 
                        if(context.mounted) Navigator.push(context, MaterialPageRoute(builder: (_) => details_page.MovieDetailsScreen(movie: RemoteConfigService.moviesDb[n.targetId]!))); 
                      } 
                    }, 
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), 
                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white10))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 100, height: 60, child: ClipRRect(borderRadius: BorderRadius.circular(4), child: n.imageUrl != null && n.imageUrl!.isNotEmpty ? Container(color: const Color(0xFF1A1A1A), child: UniversalImage(path: n.imageUrl!, fit: BoxFit.cover)) : Container(color: Colors.white10, child: const Icon(Icons.notifications, color: AppColors.primary)))), 
                          const SizedBox(width: 12), 
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(n.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)), 
                            const SizedBox(height: 4),
                            Text(n.body, style: const TextStyle(color: Colors.white70, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis), 
                            const SizedBox(height: 8),
                            Text(n.time, style: const TextStyle(color: Colors.grey, fontSize: 10))
                          ])),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert, color: Colors.grey, size: 20),
                            color: const Color(0xFF202020),
                            onSelected: (value) { if (value == 'delete') manager.deleteNotification(n.id); },
                            itemBuilder: (BuildContext context) => [PopupMenuItem<String>(value: 'delete', child: Text(manager.tr('delete'), style: const TextStyle(color: Colors.redAccent)))]
                          )
                        ]
                      )
                    )
                  ); 
                }
              );
            }
          )
    ); 
  } 
}
