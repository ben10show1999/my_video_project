import 'package:flutter/material.dart';
import '../../core/components/universal_image.dart';
import '../../core/theme/app_colors.dart';
import '../details/movie_details_screen.dart';

class MyListScreen extends StatelessWidget { const MyListScreen({super.key}); 
  @override Widget build(BuildContext context) { 
    final l = List.generate(6, (i) => "https://via.placeholder.com/300x450?text=Saved+$i"); 
    return Scaffold(backgroundColor: AppColors.background, appBar: AppBar(title: const Text("My List")), body: Padding(padding: const EdgeInsets.all(16), child: LayoutBuilder(builder: (c, cs) { 
      int cnt = (cs.maxWidth / 140).floor().clamp(3, 8); 
      return GridView.builder(
        // FIX: AspectRatio 0.55 ensures space for text below the image
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cnt, childAspectRatio: 0.55, crossAxisSpacing: 16, mainAxisSpacing: 16), 
        itemCount: l.length, 
        itemBuilder: (c, i) => InkWell(onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => const MovieDetailsScreen())), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(borderRadius: BorderRadius.circular(8), child: UniversalImage(path: l[i])),
          const SizedBox(height: 8), 
          Text("Movie Title $i", maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 13))
        ]))
      ); 
    }))); 
  } 
}
