import 'dart:math';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';

class FullscreenVideoPage extends StatefulWidget {
  final Player player;
  final VideoController controller;
  final double ratio;
  final VoidCallback onExit;
  
  const FullscreenVideoPage({super.key, required this.player, required this.controller, required this.ratio, required this.onExit});
  @override State<FullscreenVideoPage> createState() => _FullscreenVideoPageState();
}

class _FullscreenVideoPageState extends State<FullscreenVideoPage> {
  bool _showControls = true;
  int _menuState = 0; // 0: none, 1: main, 2: speed, 3: quality, 4: subtitles
  double? _draggingValue;

  @override Widget build(BuildContext context) {
    final p = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(child: Video(controller: widget.controller, controls: NoVideoControls, fit: BoxFit.contain)),
          Positioned.fill(child: GestureDetector(behavior: HitTestBehavior.translucent, onTap: () { setState(() { _showControls = !_showControls; if(!_showControls) _menuState = 0; }); }, child: Container(color: Colors.transparent))),
          if (_showControls) _buildControls(p),
          if (_menuState != 0) _buildMenu(p),
          if (_showControls) Positioned(top: 20, right: 20, child: SafeArea(child: IconButton(icon: const Icon(Icons.fullscreen_exit, color: Colors.white, size: 30), onPressed: () { widget.onExit(); Navigator.pop(context); }))),
        ],
      ),
    );
  }

  Widget _buildControls(AppProvider p) => Positioned(bottom: 0, left: 0, right: 0, child: Container(color: Colors.black54, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: SafeArea(top: false, child: Column(mainAxisSize: MainAxisSize.min, children: [
    SliderTheme(data: SliderThemeData(trackHeight: 2, thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6)), child: StreamBuilder<Duration>(stream: widget.player.stream.position, builder: (c, s) { final pos = s.data ?? Duration.zero; final dur = widget.player.state.duration; final currentVal = _draggingValue ?? pos.inSeconds.toDouble(); return Row(children: [Text("${pos.inMinutes}:${(pos.inSeconds % 60).toString().padLeft(2, '0')}", style: const TextStyle(color: Colors.white, fontSize: 12)), Expanded(child: Slider(value: currentVal.clamp(0, dur.inSeconds.toDouble()), min: 0, max: dur.inSeconds.toDouble() > 0 ? dur.inSeconds.toDouble() : 1, activeColor: Colors.amber, inactiveColor: Colors.white24, onChangeStart: (v) => setState(() => _draggingValue = v), onChanged: (v) => setState(() => _draggingValue = v), onChangeEnd: (v) { widget.player.seek(Duration(seconds: v.toInt())); setState(() => _draggingValue = null); })), Text("${dur.inMinutes}:${(dur.inSeconds % 60).toString().padLeft(2, '0')}", style: const TextStyle(color: Colors.white, fontSize: 12))]); })),
    Row(children: [
      StreamBuilder<bool>(stream: widget.player.stream.playing, builder: (c, s) => IconButton(icon: Icon((s.data ?? false) ? Icons.pause : Icons.play_arrow, color: Colors.white), onPressed: () => widget.player.playOrPause())), 
      StreamBuilder<double>(stream: widget.player.stream.volume, builder: (c, s) => IconButton(icon: Icon((s.data == 0) ? Icons.volume_off : Icons.volume_up, color: Colors.white), onPressed: () => widget.player.setVolume(widget.player.state.volume == 0 ? 100 : 0))),
      const Spacer(), 
      IconButton(icon: Icon(Icons.settings, color: _menuState != 0 ? Colors.amber : Colors.white), onPressed: () => setState(() => _menuState = _menuState == 0 ? 1 : 0))
    ])
  ]))));

  Widget _buildMenu(AppProvider p) {
    final size = MediaQuery.of(context).size;
    return Positioned(bottom: 70, right: 20, child: Material(color: Colors.transparent, child: Container(width: min(280.0, size.width * 0.45), constraints: BoxConstraints(maxHeight: size.height * 0.6), padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF1E1E1E).withValues(alpha: 0.95), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)), child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: _menuContent(p))))));
  }

  List<Widget> _menuContent(AppProvider p) {
    if (_menuState == 1) {
      return [
      ListTile(dense: true, title: Text(p.tr('speed'), style: const TextStyle(color: Colors.white)), onTap: () => setState(() => _menuState = 2), trailing: const Icon(Icons.chevron_right, color: Colors.white)), 
    ];
    }
    if (_menuState == 2) {
      return [
      ListTile(dense: true, title: Text(p.tr('back'), style: const TextStyle(color: Colors.amber)), onTap: () => setState(() => _menuState = 1)), 
      ...[0.5, 1.0, 1.5, 2.0].map((s) => ListTile(dense: true, title: Text("${s}x", style: TextStyle(color: widget.player.state.rate == s ? Colors.amber : Colors.white)), onTap: () => setState(() => widget.player.setRate(s))))
    ];
    }
    return [];
  }
}
