import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/components/universal_image.dart';
import '../details/components/lazy_horizontal_section.dart';
import '../details/movie_details_screen.dart' deferred as details; // 🔥 التحميل المؤجل
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withValues(alpha: 0.6),
        elevation: 0,
        leading: const Icon(Icons.movie_filter_rounded, color: AppColors.primary, size: 32),
        title: Row(
          children: [
            TextButton(onPressed: (){}, child: const Text("Home", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
            const SizedBox(width: 10),
            TextButton(onPressed: (){}, child: const Text("TV Shows", style: TextStyle(color: Colors.white70))),
            const SizedBox(width: 10),
            TextButton(onPressed: (){}, child: const Text("Movies", style: TextStyle(color: Colors.white70))),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 28),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())),
          ),
          const SizedBox(width: 20),
          Container(width: 35, height: 35, decoration: const BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle)),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            const SizedBox(height: 20),
            _buildSection(context, "Trending Now"),
            _buildSection(context, "New Releases"),
            _buildSection(context, "Action Movies"),
            _buildSection(context, "Sci-Fi & Fantasy"),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return SizedBox(
      height: 600,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // الخلفية
          const UniversalImage(path: "https://image.tmdb.org/t/p/original/u3bZgnGQ9T01sWNhyve4z0w50V6.jpg", fit: BoxFit.cover, width: double.infinity, height: double.infinity),
          // التدرج اللوني
          Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.black, Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter, stops: [0.0, 0.6]))),
          Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.black87, Colors.transparent], begin: Alignment.centerLeft, end: Alignment.centerRight, stops: [0.0, 0.5]))),
          
          // المحتوى
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("STRANGER THINGS", style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2)),
                const SizedBox(height: 15),
                const Text("When a young boy vanishes, a small town uncovers a mystery involving secret experiments.", style: TextStyle(color: Colors.white70, fontSize: 18, height: 1.5)),
                const SizedBox(height: 30),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _openDetails(context),
                      icon: const Icon(Icons.play_arrow, color: Colors.black),
                      label: const Text("Play", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton.icon(
                      onPressed: () => _openDetails(context),
                      icon: const Icon(Icons.info_outline, color: Colors.white),
                      label: const Text("More Info", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white24, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title) {
    // نستخدم الـ Widget الجاهز الذي بنيناه سابقاً
    return LazyHorizontalSection(
      title: title,
      initialMovies: List.generate(8, (i) => MovieSnippet(id: "$i", imageUrl: "https://via.placeholder.com/200x300?text=Movie+$i", title: "Movie $i")), 
      onLoadMore: () async => [],
    );
  }

  void _openDetails(BuildContext context) {
    // 🔥 الانتقال مع التحميل المؤجل (Code Splitting)
    Navigator.push(context, MaterialPageRoute(builder: (_) => FutureBuilder(
      future: details.loadLibrary(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.done) return details.MovieDetailsScreen();
        return const Scaffold(backgroundColor: Colors.black, body: Center(child: CircularProgressIndicator(color: AppColors.primary)));
      },
    )));
  }
}
