import 'package:flutter/material.dart';
import '../../../../core/components/universal_image.dart';

class MovieSnippet { final String id; final String imageUrl; final String title; MovieSnippet({required this.id, required this.imageUrl, required this.title}); }

class LazyHorizontalSection extends StatefulWidget {
  final String title; final List<MovieSnippet> initialMovies; final Future<List<MovieSnippet>> Function() onLoadMore;
  const LazyHorizontalSection({super.key, required this.title, required this.initialMovies, required this.onLoadMore});
  @override
  State<LazyHorizontalSection> createState() => _LazyHorizontalSectionState();
}

class _LazyHorizontalSectionState extends State<LazyHorizontalSection> {
  late List<MovieSnippet> _movies; final ScrollController _sc = ScrollController(); bool _isLoading = false; bool _hasMore = true;
  @override
  void initState() { super.initState(); _movies = List.from(widget.initialMovies); _sc.addListener(() { if (_sc.position.pixels >= _sc.position.maxScrollExtent * 0.8 && !_isLoading && _hasMore) _loadMore(); }); }
  Future<void> _loadMore() async { setState(() => _isLoading = true); final newM = await widget.onLoadMore(); if (mounted) {
    setState(() { if (newM.isEmpty) {
    _hasMore = false;
  } else {
    _movies.addAll(newM);
  } _isLoading = false; });
  } }
  @override
  void dispose() { _sc.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Row(children: [Container(width: 4, height: 20, color: Colors.amber), const SizedBox(width: 8), Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))])),
        const SizedBox(height: 12),
        SizedBox(height: 220, child: LayoutBuilder(builder: (ctx, cons) {
            double w = (cons.maxWidth - 32) / 3; if (w < 110) w = 110;
            return ListView.separated(controller: _sc, scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _movies.length + (_isLoading ? 1 : 0), separatorBuilder: (_,__) => const SizedBox(width: 10), itemBuilder: (c, i) {
                if (i == _movies.length) return const Center(child: CircularProgressIndicator(color: Colors.amber));
                final m = _movies[i];
                return SizedBox(width: w, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: UniversalImage(path: m.imageUrl))), const SizedBox(height: 6), Text(m.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontSize: 12))]));
            });
        })),
    ]);
  }
}
