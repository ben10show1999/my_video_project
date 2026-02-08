import 'package:flutter/material.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/data/mock_data.dart';
import 'package:my_video_project/presentation/details/movie_details_screen.dart';

class LazyHorizontalSection extends StatelessWidget { final String title; final List<MovieSnippet> initialMovies; const LazyHorizontalSection({super.key, required this.title, required this.initialMovies});
  @override Widget build(BuildContext context) { return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))), const SizedBox(height: 12), SizedBox(height: 180, child: ListView.separated(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: initialMovies.length, separatorBuilder: (_,__) => const SizedBox(width: 10), itemBuilder: (c, i) => InkWell(onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: MockData.allMovies.first))), child: AspectRatio(aspectRatio: 2/3, child: ClipRRect(borderRadius: BorderRadius.circular(8), child: UniversalImage(path: initialMovies[i].imageUrl))))))]); } 
}
