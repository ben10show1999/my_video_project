import 'package:flutter/material.dart';
import '../../../../core/components/universal_image.dart';
import '../../../../data/models/movie_models.dart';
import '../../common/view_all_screen.dart';

class LazyHorizontalSection extends StatefulWidget { final String title; final List<MovieSnippet> initialMovies; final Future<List<MovieSnippet>> Function() onLoadMore; const LazyHorizontalSection({super.key, required this.title, required this.initialMovies, required this.onLoadMore}); @override State<LazyHorizontalSection> createState() => _LazyHorizontalSectionState(); }
class _LazyHorizontalSectionState extends State<LazyHorizontalSection> { late List<MovieSnippet> _m; final ScrollController _sc = ScrollController(); bool _load = false; bool _more = true; @override void initState() { super.initState(); _m = List.from(widget.initialMovies); _sc.addListener(() { if (_sc.position.pixels >= _sc.position.maxScrollExtent * 0.8 && !_load && _more) _fetch(); }); } Future<void> _fetch() async { setState(() => _load = true); final n = await widget.onLoadMore(); if (mounted) {
  setState(() { if (n.isEmpty) {
  _more = false;
} else {
  _m.addAll(n);
} _load = false; });
} } 
  @override Widget build(BuildContext context) { 
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Row(children: [Container(width: 4, height: 20, color: Colors.amber), const SizedBox(width: 8), Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), const Spacer(), TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ViewAllScreen(title: widget.title, movies: _m))), child: const Text("View All"))])), 
      const SizedBox(height: 12), 
      LayoutBuilder(builder: (c, cs) {
        double screenWidth = MediaQuery.of(context).size.width;
        int itemsToShow = screenWidth > 1200 ? 7 : screenWidth > 800 ? 5 : 3;
        double itemWidth = (screenWidth - 48) / itemsToShow; 
        double itemHeight = itemWidth * 1.5; // Ratio 2:3

        return SizedBox(height: itemHeight + 35, child: ListView.separated(controller: _sc, scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _m.length + (_load ? 1 : 0), separatorBuilder: (_,__) => const SizedBox(width: 10), itemBuilder: (c, i) { 
          if (i == _m.length) return const Center(child: CircularProgressIndicator(color: Colors.amber)); 
          final m = _m[i]; 
          return InkWell(onTap: () {}, child: SizedBox(width: itemWidth, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(borderRadius: BorderRadius.circular(8), child: UniversalImage(path: m.imageUrl, fit: BoxFit.cover)), 
            const SizedBox(height: 6), 
            Text(m.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontSize: 12))
          ]))); 
        }));
      })
    ]); 
  } 
}
