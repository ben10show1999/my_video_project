import 'package:flutter/material.dart';
import '../../core/components/universal_image.dart';
import '../details/movie_details_screen.dart' deferred as details;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // مربع البحث
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[900],
                  hintText: "Search for a show, movie, genre, etc.",
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () => _searchCtrl.clear(),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                ),
              ),
            ),
            
            // شبكة النتائج
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // ثلاثة أعمدة
                  childAspectRatio: 0.65, // نسبة العرض للارتفاع للبوستر
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 20, // عدد وهمي
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (_) => FutureBuilder(
                         future: details.loadLibrary(),
                         builder: (ctx, snap) => snap.connectionState == ConnectionState.done ? details.MovieDetailsScreen() : const Center(child: CircularProgressIndicator())
                       )));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: const UniversalImage(
                        path: "https://via.placeholder.com/150x220", 
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}