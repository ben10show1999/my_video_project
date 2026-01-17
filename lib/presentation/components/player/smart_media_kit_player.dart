import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import '../../../core/components/universal_image.dart';
import '../../../data/models/movie_models.dart';
import '../ads/ads_system.dart';

enum SettingsMenuState { none, main, speed, quality, subtitles }

class SmartMediaKitPlayer extends StatefulWidget {
  final List<VideoSourceModel> sources;
  final String? thumbnailUrl;
  final double targetAspectRatio;

  const SmartMediaKitPlayer({super.key, required this.sources, this.thumbnailUrl, this.targetAspectRatio = 16 / 9});
  @override
  State<SmartMediaKitPlayer> createState() => _SmartMediaKitPlayerState();
}

class _SmartMediaKitPlayerState extends State<SmartMediaKitPlayer> {
  late final Player player;
  late final VideoController controller;
  
  SettingsMenuState _menuState = SettingsMenuState.none;
  bool _isAdShowing = false;
  bool _isThumbnailVisible = true;
  bool _isLooping = false;
  bool _isAiTranslationEnabled = false;
  
  @override
  void initState() {
    super.initState();
    player = Player();
    controller = VideoController(player);
    if (widget.sources.isNotEmpty) player.open(Media(widget.sources.first.url), play: false);
    
    player.stream.playing.listen((playing) {
      if (playing && _isThumbnailVisible && mounted) setState(() => _isThumbnailVisible = false);
    });
  }

  void _closeAdAndResume() { if (mounted) { setState(() => _isAdShowing = false); player.play(); } }
  void _toggleLoop() { setState(() { _isLooping = !_isLooping; player.setPlaylistMode(_isLooping ? PlaylistMode.single : PlaylistMode.none); }); }
  @override
  void dispose() { player.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.targetAspectRatio,
      child: Container(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Video(controller: controller, controls: NoVideoControls, fit: BoxFit.contain),
            if (widget.thumbnailUrl != null)
              AnimatedOpacity(
                opacity: _isThumbnailVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: IgnorePointer(ignoring: !_isThumbnailVisible, child: UniversalImage(path: widget.thumbnailUrl!, fit: BoxFit.cover, width: double.infinity, height: double.infinity)),
              ),
            if (!_isAdShowing && _isThumbnailVisible && !player.state.playing)
               Center(child: IconButton(iconSize: 64, icon: const Icon(Icons.play_circle_fill, color: Colors.white), onPressed: () => player.play())),
            if (!_isAdShowing) _buildControlsOverlay(),
            if (!_isAdShowing && _menuState != SettingsMenuState.none) _buildSettingsMenu(),
            if (_isAdShowing)
              Positioned.fill(
                child: Container(color: Colors.black87, child: Center(child: SizedBox(width: 600, child: SmartAdContainer(
                  adAspectRatio: 16/9, onClose: _closeAdAndResume, externalUrl: "https://example.com",
                  adContent: ReliableAdLoader(
                    adUrl: "https://via.placeholder.com/600x340.png?text=Ad+Content",
                    adBuilder: (ctx, url) => Image.network(url, fit: BoxFit.cover, errorBuilder: (c,e,s) {
                       WidgetsBinding.instance.addPostFrameCallback((_) => c.findAncestorStateOfType<ReliableAdLoaderState>()?.triggerError());
                       return const SizedBox();
                    }),
                  ),
                )))),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlsOverlay() {
      return Positioned(bottom: 0, left: 0, right: 0, child: Container(color: Colors.black54, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: SafeArea(top: false, child: Row(children: [
          IconButton(icon: Icon(player.state.playing ? Icons.pause : Icons.play_arrow, color: Colors.white), onPressed: player.playOrPause),
          IconButton(icon: Icon(_isLooping ? Icons.repeat_one : Icons.repeat, color: _isLooping ? Colors.amber : Colors.white), onPressed: _toggleLoop),
          const Spacer(),
          IconButton(icon: Icon(Icons.settings, color: _menuState != SettingsMenuState.none ? Colors.amber : Colors.white), onPressed: () => setState(() => _menuState = _menuState == SettingsMenuState.none ? SettingsMenuState.main : SettingsMenuState.none)),
      ]))));
  }

  Widget _buildSettingsMenu() {
      return Positioned(bottom: 70, right: 20, child: Material(color: Colors.transparent, child: Container(width: 250, padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFF1E1E1E).withValues(alpha: 0.95), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)), child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (_menuState == SettingsMenuState.main) ...[ _menuItem("Speed", Icons.speed, () => setState(() => _menuState = SettingsMenuState.speed)), const Divider(color: Colors.white10, height: 1), _menuItem("Subtitles", Icons.subtitles, () => setState(() => _menuState = SettingsMenuState.subtitles))],
          if (_menuState == SettingsMenuState.speed) ...[ _backHeader("Speed"), ...[0.5, 1.0, 1.5, 2.0].map((s) => _radioItem("${s}x", player.state.rate == s, () => player.setRate(s)))],
          if (_menuState == SettingsMenuState.subtitles) ...[ _backHeader("Subtitles"), Row(children: [const SizedBox(width: 12), const Icon(Icons.auto_awesome, color: Colors.amber, size: 16), const SizedBox(width: 8), const Text("AI Translate", style: TextStyle(color: Colors.white)), const Spacer(), Switch(value: _isAiTranslationEnabled, onChanged: (v) => setState(() => _isAiTranslationEnabled = v), activeThumbColor: Colors.amber)]), const Divider(color: Colors.white10), _radioItem("Off", player.state.track.subtitle == SubtitleTrack.no(), () => player.setSubtitleTrack(SubtitleTrack.no()))]
      ]))));
  }
  Widget _menuItem(String t, IconData i, VoidCallback o) => ListTile(leading: Icon(i, color: Colors.white, size: 20), title: Text(t, style: const TextStyle(color: Colors.white)), onTap: o, dense: true);
  Widget _backHeader(String t) => InkWell(onTap: () => setState(() => _menuState = SettingsMenuState.main), child: Padding(padding: const EdgeInsets.all(8), child: Row(children: [const Icon(Icons.arrow_back_ios, color: Colors.white, size: 14), Text(t, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))])));
  Widget _radioItem(String t, bool s, VoidCallback o) => ListTile(title: Text(t, style: TextStyle(color: s ? Colors.amber : Colors.white)), trailing: s ? const Icon(Icons.check, color: Colors.amber, size: 18) : null, onTap: o, dense: true);
}
