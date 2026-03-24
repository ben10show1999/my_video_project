import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_video_project/core/theme/app_colors.dart';
import 'package:web/web.dart' as web;
import 'dart:js_interop';

class UniversalImage extends StatefulWidget {
  final String path; final BoxFit fit; final double? width; final double? height;
  const UniversalImage({super.key, required this.path, this.fit = BoxFit.cover, this.width, this.height});
  @override State<UniversalImage> createState() => _UniversalImageState();
}
class _UniversalImageState extends State<UniversalImage> {
  String? _ephemeralUrl; bool _isError = false;
  @override void initState() { super.initState(); _loadStealthImage(); }
  Future<void> _loadStealthImage() async {
    if (!widget.path.startsWith('http')) return;
    try {
      final response = await http.get(Uri.parse(widget.path));
      if (response.statusCode == 200) {
        final blob = web.Blob([response.bodyBytes.toJS].toJS, web.BlobPropertyBag(type: 'image/webp'));
        final url = web.URL.createObjectURL(blob);
        if (mounted) setState(() => _ephemeralUrl = url);
        Future.delayed(const Duration(milliseconds: 500), () { try { web.URL.revokeObjectURL(url); } catch(e) { /* ✅ FIX 3: Ignore URL revocation errors silently */ } });
      } else { if (mounted) setState(() => _isError = true); }
    } catch (e) { if (mounted) setState(() => _isError = true); }
  }
  @override Widget build(BuildContext context) { 
    if (!widget.path.startsWith('http')) return Image.asset(widget.path, fit: widget.fit, width: widget.width, height: widget.height);
    if (_isError) return Center(child: Icon(Icons.broken_image, color: Colors.white12, size: widget.width ?? 40));
    if (_ephemeralUrl == null) return const Center(child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2));
    return AspectRatio(aspectRatio: 2/3, child: Container(color: Colors.transparent, child: Image.network(_ephemeralUrl!, fit: widget.fit, width: widget.width, height: widget.height, errorBuilder: (c, e, s) => Center(child: Icon(Icons.broken_image, color: Colors.white12, size: widget.width ?? 40))))); 
  }
}
