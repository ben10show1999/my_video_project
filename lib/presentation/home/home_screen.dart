import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/data/mock_data.dart';
import 'package:my_video_project/presentation/details/components/lazy_horizontal_section.dart';
import 'package:my_video_project/presentation/details/movie_details_screen.dart';
class HomeScreen extends StatelessWidget { const HomeScreen({super.key}); 
  @override Widget build(BuildContext context) { final p = Provider.of<AppProvider>(context); return Scaffold(extendBodyBehindAppBar: true, appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0), body: SingleChildScrollView(child: Column(children: [SizedBox(height: MediaQuery.of(context).size.height * 0.6, width: double.infinity, child: Stack(fit: StackFit.expand, children: [const UniversalImage(path: "https://via.placeholder.com/1920x1080?text=Featured", fit: BoxFit.cover), Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.black, Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.center))), Positioned(bottom: 40, left: 20, child: ElevatedButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: MockData.allMovies.first))), icon: const Icon(Icons.play_arrow), label: Text(p.tr('visit'))))])), const SizedBox(height: 24), LazyHorizontalSection(title: p.tr('trending'), initialMovies: MockData.allMovies.map((m) => MovieSnippet(id: m.id.toString(), imageUrl: m.posterPath, title: m.title)).toList()), const SizedBox(height: 40)]))); } 
}
