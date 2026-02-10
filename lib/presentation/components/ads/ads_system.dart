import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

// Task 17: Immortal Container
class SmartAdContainer extends StatefulWidget {
  final VoidCallback onClose;
  final Widget child; // The actual Ad (WebAdInjector or Image)
  final double aspectRatio;
  const SmartAdContainer({super.key, required this.onClose, required this.child, this.aspectRatio = 16/9});

  @override
  State<SmartAdContainer> createState() => _SmartAdContainerState();
}

class _SmartAdContainerState extends State<SmartAdContainer> {
  bool _isConnected = true;
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _checkConnection();
    _sub = Connectivity().onConnectivityChanged.listen((l) {
      bool hasNet = !l.contains(ConnectivityResult.none);
      if (hasNet != _isConnected) setState(() => _isConnected = hasNet);
    });
  }

  void _checkConnection() async {
    final l = await Connectivity().checkConnectivity();
    setState(() => _isConnected = !l.contains(ConnectivityResult.none));
  }

  @override
  void dispose() { _sub?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<AppProvider>(context);
    
    return Stack(
      children: [
        // Task 18: Strict Isolation & Adaptive Geometry
        AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: Container(
            color: Colors.black,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: RepaintBoundary(
                // Task 17: Connection Trap
                child: _isConnected 
                    ? widget.child 
                    : Container(
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(color: AppColors.primary),
                            const SizedBox(height: 12),
                            Text(p.tr('ad_wait_net'), style: const TextStyle(color: Colors.white70, fontSize: 12))
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
        // Close Button (Only way out)
        if (_isConnected)
          Positioned(
            top: 8, right: 8,
            child: PointerInterceptor( // Needed to click over IFrame
              child: GestureDetector(
                onTap: widget.onClose,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(20)),
                  child: Text(p.tr('close_ad'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
