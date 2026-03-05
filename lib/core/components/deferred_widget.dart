import 'package:flutter/material.dart';

// ✅ Task 8: Universal Deferred Loader for Zero-Repetition Code Splitting
class DeferredWidget extends StatefulWidget {
  final Future<void> Function() loadLibrary;
  final Widget Function() builder;
  
  const DeferredWidget({super.key, required this.loadLibrary, required this.builder});
  @override State<DeferredWidget> createState() => _DeferredWidgetState();
}

class _DeferredWidgetState extends State<DeferredWidget> {
  bool _isLoaded = false;
  
  @override void initState() {
    super.initState();
    widget.loadLibrary().then((_) {
      if (mounted) setState(() => _isLoaded = true);
    });
  }

  @override Widget build(BuildContext context) {
    if (_isLoaded) return widget.builder();
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: CircularProgressIndicator(color: Colors.amber)),
    );
  }
}
