import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/data/mock_data.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/presentation/details/movie_details_screen.dart';
class SearchScreen extends StatefulWidget { const SearchScreen({super.key}); @override State<SearchScreen> createState() => _S(); }
class _S extends State<SearchScreen> { 
  List<MovieModel> _filt = []; 
  @override void initState() { super.initState(); _filt = MockData.allMovies; } 
  void _run(String k) => setState(() => _filt = k.isEmpty ? MockData.allMovies : MockData.allMovies.where((e) => e.title.toLowerCase().contains(k.toLowerCase())).toList()); 
  @override Widget build(BuildContext context) { final p = Provider.of<AppProvider>(context); return Scaffold(appBar: AppBar(title: Text(p.tr('search'))), body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [TextField(onChanged: _run, style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: p.tr('search'), filled: true, fillColor: const Color(0xFF202020), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))), const SizedBox(height: 20), Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 2/3, crossAxisSpacing: 10, mainAxisSpacing: 10), itemCount: _filt.length, itemBuilder: (c, i) => InkWell(onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: _filt[i]))), child: UniversalImage(path: _filt[i].posterPath))))]))); } 
}
