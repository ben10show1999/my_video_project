import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class UniversalImage extends StatelessWidget {
  final String path;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? errorPlaceholder;

  const UniversalImage({
    super.key,
    required this.path,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.errorPlaceholder,
  });

  @override
  Widget build(BuildContext context) {
    if (path.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: path,
        width: width, height: height, fit: fit,
        placeholder: (context, url) => Container(
          width: width, height: height,
          color: AppColors.surface,
          child: const Center(child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2)),
        ),
        errorWidget: (context, url, error) => _buildError(),
      );
    } else {
      return Image.asset(
        path,
        width: width, height: height, fit: fit,
        errorBuilder: (context, error, stackTrace) => _buildError(),
      );
    }
  }

  Widget _buildError() {
    return errorPlaceholder ?? Container(
      width: width, height: height, color: AppColors.surface,
      child: const Icon(Icons.broken_image_rounded, color: Colors.grey),
    );
  }
}
