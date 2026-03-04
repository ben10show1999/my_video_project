import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
class UniversalImage extends StatelessWidget { final String path; final BoxFit fit; const UniversalImage({super.key, required this.path, this.fit = BoxFit.cover}); @override Widget build(BuildContext context) { return AspectRatio(aspectRatio: 2 / 3, child: Container(color: const Color(0xFF1A1A1A), child: _buildImage())); } Widget _buildImage() { if (path.startsWith('http')) {
  return CachedNetworkImage(imageUrl: path, fit: fit, placeholder: (c, u) => const Center(child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2)), errorWidget: (c, u, e) => _buildErrorWidget());
} else {
  return Image.asset(path, fit: fit, errorBuilder: (c, e, s) => _buildErrorWidget());
} } Widget _buildErrorWidget() { return LayoutBuilder(builder: (c, cs) => Center(child: Icon(Icons.broken_image_rounded, color: Colors.white12, size: cs.maxWidth * 0.4))); } }
