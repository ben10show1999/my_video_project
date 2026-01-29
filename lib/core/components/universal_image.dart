import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
class UniversalImage extends StatelessWidget {
  final String path; final BoxFit fit; final double? width; final double? height; final Widget? errorPlaceholder;
  const UniversalImage({super.key, required this.path, this.fit = BoxFit.cover, this.width, this.height, this.errorPlaceholder});
  @override Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 2 / 3, child: _buildImage());
  }
  Widget _buildImage() {
    if (path.startsWith('http')) {
      return CachedNetworkImage(imageUrl: path, fit: fit, width: width, height: height, placeholder: (c, u) => Container(color: AppColors.surface, child: const Center(child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2))), errorWidget: (c, u, e) => _buildErrorWidget());
    } else { return Image.asset(path, fit: fit, width: width, height: height, errorBuilder: (c, e, s) => _buildErrorWidget()); }
  }
  Widget _buildErrorWidget() {
    if (errorPlaceholder != null) return errorPlaceholder!;
    return Container(color: AppColors.surface, child: LayoutBuilder(builder: (context, constraints) { return Center(child: Icon(Icons.broken_image_rounded, color: Colors.grey, size: constraints.maxWidth * 0.3)); }));
  }
}
