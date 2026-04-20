import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
import 'package:my_video_project/core/services/remote_config_service.dart';
import 'package:my_video_project/presentation/details/movie_details_screen.dart' deferred as details_page;

class MyListScreen extends StatelessWidget { 
  const MyListScreen({super.key}); 
  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context); 
    final l = RemoteConfigService.allSnippets.where((m) => p.isInList(m.id)).toList(); 
    return Scaffold(
      backgroundColor: AppColors.background, 
      appBar: AppBar(title: Text(p.tr('list')), centerTitle: true, backgroundColor: Colors.transparent, elevation: 0, leading: BackButton(color: Colors.white, onPressed: () { if (p.navIndex != 0) { p.setNavIndex(0); } else { Navigator.pop(context); } })), 
      body: l.isEmpty ? Center(child: Text(p.tr('empty_list'), style: const TextStyle(color: Colors.grey))) : Padding(padding: const EdgeInsets.all(16), child: LayoutBuilder(builder: (c, cs) { int cnt = (cs.maxWidth / 150).floor().clamp(3, 8); double itemW = (cs.maxWidth - (cnt - 1) * 16) / cnt; double itemH = (itemW * 1.5) + 65; double ratio = itemW / itemH; return GridView.builder(padding: const EdgeInsets.only(bottom: 120), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cnt, childAspectRatio: ratio, crossAxisSpacing: 16, mainAxisSpacing: 16), itemCount: l.length, itemBuilder: (c, i) => InkWell(onTap: () async { if(RemoteConfigService.moviesDb.containsKey(l[i].id)){ await details_page.loadLibrary(); if(context.mounted) Navigator.push(c, MaterialPageRoute(builder: (_) => details_page.MovieDetailsScreen(movie: RemoteConfigService.moviesDb[l[i].id]!))); } }, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ClipRRect(borderRadius: BorderRadius.circular(8), child: Container(color: const Color(0xFF1A1A1A), child: UniversalImage(path: l[i].imageUrl))), const SizedBox(height: 8), Text(l[i].title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 13))]))); }))
    ); 
  } 
}
