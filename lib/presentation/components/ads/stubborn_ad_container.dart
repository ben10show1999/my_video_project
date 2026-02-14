import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'web_iframe_ad.dart';

// Task 12 & 13: Stubborn Container & Geometric Containment
class StubbornAdContainer extends StatefulWidget {
  final VoidCallback onClose;
  final String? scriptCode; 
  final Widget? simpleContent; 
  final double adAspectRatio;

  const StubbornAdContainer({super.key, required this.onClose, this.scriptCode, this.simpleContent, this.adAspectRatio = 16/9});
  @override
  State<StubbornAdContainer> createState() => _StubbornAdContainerState();
}

class _StubbornAdContainerState extends State<StubbornAdContainer> {
  bool _isConnected = true;
  bool _isLoading = true;
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _checkInitial();
    // Task 12: Auto-Retry Logic (Stubborn)
    _sub = Connectivity().onConnectivityChanged.listen((l) {
      bool hasNet = !l.contains(ConnectivityResult.none);
      if (hasNet && !_isConnected) {
        setState(() { _isConnected = true; _isLoading = true; });
        // Simulate reload delay
        Future.delayed(const Duration(seconds: 1), () => setState(() => _isLoading = false));
      } else if (!hasNet) {
        setState(() => _isConnected = false);
      }
    });
    // Mock initial loading finish
    Future.delayed(const Duration(seconds: 2), () => setState(() => _isLoading = false));
  }
  
  void _checkInitial() async {
    final l = await Connectivity().checkConnectivity();
    setState(() => _isConnected = !l.contains(ConnectivityResult.none));
  }

  @override
  void dispose() { _sub?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<AppProvider>(context);
    
    // Task 13: Strict Clipping & Dimmed Background
    return ClipRect(
      child: Container(
        color: Colors.black.withValues(alpha: 0.8), // Focus Theater
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Content Layer
            if (!_isConnected)
              Column(mainAxisSize: MainAxisSize.min, children: [
                 const Icon(Icons.cloud_off, color: Colors.white54, size: 40),
                 const SizedBox(height: 8),
                 Text(p.tr('ad_error'), style: const TextStyle(color: Colors.white54))
              ])
            else if (_isLoading)
               Column(mainAxisSize: MainAxisSize.min, children: [
                 const CircularProgressIndicator(color: Colors.amber),
                 const SizedBox(height: 8),
                 Text(p.tr('ad_loading'), style: const TextStyle(color: Colors.white54))
               ])
            else
               widget.scriptCode != null 
                 ? WebIframeAd(scriptContent: widget.scriptCode!, width: 300, height: 250) // Task 14
                 : AspectRatio(aspectRatio: widget.adAspectRatio, child: widget.simpleContent ?? const SizedBox()),

            // Task 12: Close Button Authority (Only exit)
            Positioned(
              top: 10, right: 10,
              child: GestureDetector(
                onTap: widget.onClose,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(20)),
                  child: Text(p.tr('close_ad'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
