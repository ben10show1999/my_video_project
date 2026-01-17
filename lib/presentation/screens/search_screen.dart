import 'package:flutter/material.dart';
import '../../core/components/universal_image.dart';
import '../../core/theme/app_colors.dart';
import '../components/web_hover_card.dart';
import '../details/movie_details_screen.dart' deferred as details;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  final List<String> _genres = ["Action", "Comedy", "Drama", "Sci-Fi", "Horror", "Romance"];
  String _selectedGenre = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, elevation: 0, leading: const BackButton(color: Colors.white)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true, fillColor: Colors.grey[900],
                hintText: "Search titles, people, or genres", hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
              ),
            ),
          ),
          
          // Genre Chips
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal, itemCount: _genres.length, separatorBuilder: (_,__) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final genre = _genres[index];
                  final isSelected = _selectedGenre == genre;
                  return ChoiceChip(
                    label: Text(genre), selected: isSelected,
                    onSelected: (val) => setState(() => _selectedGenre = val ? genre : ""),
                    backgroundColor: Colors.grey[900], selectedColor: AppColors.primary,
                    labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.grey),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide.none),
                  );
                },
              ),
            ),
          ),

          // Responsive Grid
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth > 1200 ? 6 : (constraints.maxWidth > 800 ? 4 : 3);
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount, childAspectRatio: 0.7, crossAxisSpacing: 15, mainAxisSpacing: 15),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return WebHoverCard(
                      onTap: () => _navigateToDetails(context),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: const UniversalImage(path: "https://via.placeholder.com/300x450", fit: BoxFit.cover),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetails(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => FutureBuilder(
      future: details.loadLibrary(),
      builder: (ctx, snap) => snap.connectionState == ConnectionState.done ? details.MovieDetailsScreen() : const Center(child: CircularProgressIndicator(color: AppColors.primary)),
    )));
  }
}
