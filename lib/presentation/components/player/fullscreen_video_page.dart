import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class FullscreenVideoPage extends StatefulWidget {
  final Player player;
  final double ratio;
  final Widget Function() controlsBuilder;
  final Widget Function() menuBuilder;
  const FullscreenVideoPage({super.key, required this.player, required this.ratio, required this.controlsBuilder, required this.menuBuilder});
  @override State<FullscreenVideoPage> createState() => _FullscreenVideoPageState();
}

class _FullscreenVideoPageState extends State<FullscreenVideoPage> {
  late final VideoController _fsController;
  
  @override void initState() {
    super.initState();
    // Create a new controller instance attached to the SAME running player!
    _fsController = VideoController(widget.player);
    
    // Strict Orientation Enforcer Before Build
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    if (widget.ratio > 1.0) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(child: Video(controller: _fsController, controls: NoVideoControls, fit: BoxFit.contain)),
          Positioned.fill(child: widget.controlsBuilder()), // Full Controls Replicated
          widget.menuBuilder(),
          Positioned(top: 20, right: 20, child: SafeArea(child: IconButton(icon: const Icon(Icons.fullscreen_exit, color: Colors.white, size: 30), onPressed: () => Navigator.pop(context)))),
        ],
      ),
    );
  }
}
