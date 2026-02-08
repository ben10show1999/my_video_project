import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class UniversalImage extends StatelessWidget {
  final String path; final BoxFit fit; final double? width; final double? height;
  const UniversalImage({super.key, required this.path, this.fit = BoxFit.cover, this.width, this.height});
  @override Widget build(BuildContext context) { 
    return AspectRatio(aspectRatio: 2 / 3, child: Container(color: const Color(0xFF1A1A1A), child: _buildImage())); 
  }
  Widget _buildImage() {
    if (path.startsWith('http')) {
      return CachedNetworkImage(imageUrl: path, fit: fit, width: width, height: height, errorWidget: (c, u, e) => const Icon(Icons.broken_image, color: Colors.white24));
    } else {
      return Image.asset(path, fit: fit, width: width, height: height, errorBuilder: (c, e, s) => const Icon(Icons.broken_image, color: Colors.white24));
    }
  }
}
