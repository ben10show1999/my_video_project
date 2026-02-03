import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_video_project/core/theme/app_colors.dart';

// �7�3 Task 22: Enforcing Structural Aspect Ratio
class UniversalImage extends StatelessWidget {
  final String path; final BoxFit fit; final double? width; final double? height; final Widget? errorPlaceholder;
  const UniversalImage({super.key, required this.path, this.fit = BoxFit.cover, this.width, this.height, this.errorPlaceholder});
  
  @override Widget build(BuildContext context) { 
    // Wrapper AspectRatio ensures the box exists even if image fails
    return AspectRatio(
      aspectRatio: 2 / 3, 
      child: Container(
        color: const Color(0xFF1A1A1A), // Placeholder background
        child: _buildImage()
      )
    ); 
  }
  
  Widget _buildImage() {
    if (path.startsWith('http')) {
      return CachedNetworkImage(imageUrl: path, fit: fit, width: width, height: height, placeholder: (c, u) => const Center(child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2)), errorWidget: (c, u, e) => _buildErrorWidget());
    } else {
      return Image.asset(path, fit: fit, width: width, height: height, errorBuilder: (c, e, s) => _buildErrorWidget());
    }
  }
  Widget _buildErrorWidget() { return LayoutBuilder(builder: (context, constraints) => Center(child: Icon(Icons.broken_image_rounded, color: Colors.white12, size: constraints.maxWidth * 0.4))); }
}
