import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_kit_video/media_kit_video.dart';

class FullscreenVideoPage extends StatefulWidget {
  final VideoController controller;
  final double ratio;
  const FullscreenVideoPage({super.key, required this.controller, required this.ratio});
  @override State<FullscreenVideoPage> createState() => _FullscreenVideoPageState();
}

class _FullscreenVideoPageState extends State<FullscreenVideoPage> {
  @override
  void initState() {
    super.initState();
    // Context-Aware Landscape or Portrait based on Aspect Ratio
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    if (widget.ratio > 1.0) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  void dispose() {
    // Revert to normal
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Video(controller: widget.controller, controls: NoVideoControls, fit: BoxFit.contain),
          ),
          Positioned(
            top: 20, right: 20,
            child: SafeArea(
              child: IconButton(
                icon: const Icon(Icons.fullscreen_exit, color: Colors.white, size: 30),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          )
        ],
      ),
    );
  }
}
