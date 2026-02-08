import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/data/mock_data.dart';
import 'package:my_video_project/presentation/details/movie_details_screen.dart';
class MyListScreen extends StatelessWidget { const MyListScreen({super.key}); 
  @override Widget build(BuildContext context) { final p = Provider.of<AppProvider>(context); final l = MockData.allMovies.where((m) => p.isInList(m.id)).toList(); return Scaffold(appBar: AppBar(title: Text(p.tr('list'))), body: l.isEmpty ? Center(child: Text(p.tr('empty_list'))) : GridView.builder(padding: const EdgeInsets.all(16), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 2/3, crossAxisSpacing: 10, mainAxisSpacing: 10), itemCount: l.length, itemBuilder: (c, i) => InkWell(onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: l[i]))), child: UniversalImage(path: l[i].posterPath)))); } 
}
