import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
import 'package:my_video_project/data/mock_data.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/presentation/details/movie_details_screen.dart';
class SearchScreen extends StatefulWidget { const SearchScreen({super.key}); @override State<SearchScreen> createState() => _S(); }
class _S extends State<SearchScreen> { List<MovieModel> _filt = []; @override void initState() { super.initState(); _filt = MockData.allMovies; } void _run(String k) => setState(() => _filt = k.isEmpty ? MockData.allMovies : MockData.allMovies.where((e) => e.title.toLowerCase().contains(k.toLowerCase())).toList()); 
  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.background, 
      appBar: AppBar(title: Text(p.tr('search')), centerTitle: true, leading: const BackButton(color: Colors.white), backgroundColor: Colors.transparent, elevation: 0),
      body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [TextField(onChanged: _run, style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: p.tr('search'), hintStyle: const TextStyle(color: Colors.grey), prefixIcon: const Icon(Icons.search, color: Colors.grey), filled: true, fillColor: const Color(0xFF202020), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))), const SizedBox(height: 20), Expanded(child: LayoutBuilder(builder: (c, cs) { 
        int cnt = (cs.maxWidth / 150).floor().clamp(3, 8); 
        return GridView.builder(padding: const EdgeInsets.only(bottom: 120), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cnt, childAspectRatio: 0.55, crossAxisSpacing: 16, mainAxisSpacing: 16), itemCount: _filt.length, itemBuilder: (c, i) => InkWell(onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: _filt[i]))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ClipRRect(borderRadius: BorderRadius.circular(8), child: UniversalImage(path: _filt[i].posterPath)), const SizedBox(height: 8), Text(_filt[i].title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 13))]))); }))]))
    ); 
  } 
}
