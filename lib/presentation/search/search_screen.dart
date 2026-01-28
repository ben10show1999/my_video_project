import 'package:flutter/material.dart';
import '../../core/components/universal_image.dart';
import '../../core/theme/app_colors.dart';
import '../details/movie_details_screen.dart';

class SearchItem { final String t; final String img; SearchItem(this.t, this.img); }
class SearchScreen extends StatefulWidget { const SearchScreen({super.key}); @override State<SearchScreen> createState() => _S(); }
class _S extends State<SearchScreen> { final List<SearchItem> _all = List.generate(20, (i) => SearchItem("Movie $i", "https://via.placeholder.com/300x450?text=$i")); List<SearchItem> _filt = []; @override void initState() { super.initState(); _filt = _all; } void _run(String k) => setState(() => _filt = k.isEmpty ? _all : _all.where((e) => e.t.toLowerCase().contains(k.toLowerCase())).toList()); 
  @override Widget build(BuildContext context) { 
    return Scaffold(backgroundColor: AppColors.background, body: SafeArea(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
      TextField(onChanged: _run, style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: "Search...", hintStyle: const TextStyle(color: Colors.grey), prefixIcon: const Icon(Icons.search, color: Colors.grey), filled: true, fillColor: const Color(0xFF202020), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))), 
      const SizedBox(height: 20), 
      Expanded(child: LayoutBuilder(builder: (c, cs) { 
        int cnt = (cs.maxWidth / 140).floor().clamp(3, 8); 
        return GridView.builder(
          // FIX: AspectRatio 0.55 ensures space for text below the image
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cnt, childAspectRatio: 0.55, crossAxisSpacing: 16, mainAxisSpacing: 16), 
          itemCount: _filt.length, 
          itemBuilder: (c, i) => InkWell(onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => const MovieDetailsScreen())), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(borderRadius: BorderRadius.circular(8), child: UniversalImage(path: _filt[i].img)), 
            const SizedBox(height: 8), 
            Text(_filt[i].t, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 13))
          ]))
        ); 
      }))
    ])))); 
  } 
}
