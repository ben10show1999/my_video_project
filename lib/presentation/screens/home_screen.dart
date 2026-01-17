import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/components/universal_image.dart';
import '../details/components/lazy_horizontal_section.dart'; // �1�9�1�8�1�9�1�7�1�2�1�0 �1�9�1�8�1�8�1�4 �1�0�1�0�1�4�1�0�1�9�1�1 �1�1�1�9�1�0�1�6�1�9�1�5
import '../details/movie_details_screen.dart' deferred as details; // �1�9�1�8�1�2�1�5�1�9�1�4�1�8 �1�9�1�8�1�9�1�6�1�4�1�8
import './search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true, // �1�8�1�4�1�7�1�8 �1�9�1�8�1�3�1�2�1�9�1�1 �1�2�1�8�1�5�1�4 �1�6�1�8�1�5 �1�9�1�8�1�0�1�9�1�9 �1�9�1�8�1�7�1�8�1�2�1�4
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/logo.png'), // �1�9�1�8�1�8�1�2�1�4�1�2
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 28),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())),
          ),
          const SizedBox(width: 10),
          // �1�5�1�4�1�6�1�2�1�0�1�1 �1�9�1�8�1�9�1�8�1�5 �1�9�1�8�1�2�1�6�1�3�1�4
          Container(
            margin: const EdgeInsets.only(right: 15),
            width: 30, height: 30,
            color: Colors.blue, // �1�3�1�2�1�9�1�1 �1�0�1�9�1�2�1�5�1�9�1�4�1�8 �1�2�1�1�1�9�1�4�1�1
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Hero Section (�1�9�1�8�1�0�1�2�1�1�1�2�1�9 �1�9�1�8�1�4�1�6�1�9 �1�5�1�4 �1�9�1�8�1�0�1�7�1�9�1�4�1�1)
            _buildHeroSection(context),
            
            // 2. �1�9�1�8�1�6�1�2�1�9�1�8�1�9 �1�9�1�8�1�5�1�5�1�6�1�4�1�1 (�1�9�1�8�1�9�1�5�1�2�1�2�1�3)
            const SizedBox(height: 20),
            _buildSection(context, "Trending Now"),
            _buildSection(context, "Top Rated"),
            _buildSection(context, "Action Movies"),
            _buildSection(context, "Sci-Fi Series"),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // �1�0�1�0�1�9�1�3 �1�6�1�1�1�9 �1�9�1�8�1�1�1�4�1�9�1�2 (Hero)
  Widget _buildHeroSection(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // �1�9�1�8�1�6�1�8�1�5�1�4�1�1
        SizedBox(
          height: 550, // �1�9�1�9�1�2�1�5�1�9�1�7 �1�7�1�0�1�4�1�9 �1�7�1�9�1�9 �1�5�1�4 Netflix
          width: double.infinity,
          child: ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent, Colors.black],
                stops: [0, 0.6, 1],
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: const UniversalImage(
              path: "https://image.tmdb.org/t/p/original/u3bZgnGQ9T01sWNhyve4z0w50V6.jpg", // �1�3�1�2�1�9�1�1 �1�9�1�8�1�1�1�4�1�9�1�2
              fit: BoxFit.cover,
            ),
          ),
        ),
        // �1�9�1�8�1�5�1�0�1�9�1�9�1�9 �1�2�1�9�1�8�1�9�1�7�1�8�1�2�1�9�1�9�1�2
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             const Text("STRANGER THINGS", 
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2)
             ),
             const SizedBox(height: 10),
             const Text("Sci-Fi �6�1 Horror �6�1 Drama", style: TextStyle(color: Colors.white70)),
             const SizedBox(height: 20),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 _HeroButton(
                   icon: Icons.play_arrow, 
                   text: "Play", 
                   color: Colors.white, 
                   textColor: Colors.black,
                   onTap: () => _openDetails(context),
                 ),
                 const SizedBox(width: 15),
                 _HeroButton(
                   icon: Icons.info_outline, 
                   text: "More Info", 
                   color: Colors.white24, 
                   textColor: Colors.white,
                   onTap: () => _openDetails(context),
                 ),
               ],
             ),
             const SizedBox(height: 30),
          ],
        )
      ],
    );
  }

  // �1�6�1�1�1�9 �1�9�1�8�1�6�1�2�1�9�1�8�1�9 �1�9�1�8�1�5�1�5�1�6�1�4�1�1
  Widget _buildSection(BuildContext context, String title) {
    return LazyHorizontalSection(
      title: title,
      initialMovies: List.generate(8, (i) => MovieSnippet(
        id: "$i", 
        imageUrl: "https://via.placeholder.com/150x220", 
        title: "Movie $i"
      )),
      onLoadMore: () async => [], // �1�1�1�0�1�9 �1�0�1�9�1�0�1�5 �1�9�1�8�1�9�1�0�1�5�1�6 �1�8�1�9�1�5�1�6�1�9�1�5
    );
  }

  void _openDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FutureBuilder(
          future: details.loadLibrary(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return details.MovieDetailsScreen();
            }
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          },
        ),
      ),
    );
  }
}

class _HeroButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const _HeroButton({required this.icon, required this.text, required this.color, required this.textColor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: textColor),
      label: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}