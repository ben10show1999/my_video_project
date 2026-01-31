import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../core/components/universal_image.dart';
import '../../../data/models/movie_models.dart';
import '../../../core/logic/app_provider.dart';
import '../ads/ads_system.dart';

enum SettingsMenuState { none, main, speed, quality, subtitles, aiLanguages }

class SmartMediaKitPlayer extends StatefulWidget {
  final List<VideoQualityModel> sources;
  final String? thumbnailUrl;
  final Function(double ratio) onAspectRatioChanged;
  final double targetAspectRatio;

  const SmartMediaKitPlayer({
    super.key,
    required this.sources,
    this.thumbnailUrl,
    required this.onAspectRatioChanged,
    this.targetAspectRatio = 16 / 9,
  });

  @override
  State<SmartMediaKitPlayer> createState() => _SmartMediaKitPlayerState();
}

class _SmartMediaKitPlayerState extends State<SmartMediaKitPlayer> {
  late final Player player;
  late final VideoController controller;
  SettingsMenuState _menuState = SettingsMenuState.none;

  bool _isAd = false;
  bool _thumb = true;
  bool _loop = false;
  bool _ai = false; // Fixed: Now used in menu
  bool _blackScreen = false;
  Timer? _recordingTimer;
  
  String _currentAiLang = "English"; // Fixed: Now used in menu
  String _currentQualityLabel = "Auto"; // Fixed: Now used in menu
  String _activeUrl = "";
  bool _isAutoMode = true; // Fixed: Now used in menu

  final List<String> _aiLanguages = ["Arabic", "English", "Spanish", "French", "German"];

  @override
  void initState() {
    super.initState();
    // �7�3 AGGRESSIVE BUFFERING: 64MB buffer for continuous loading
    player = Player(configuration: const PlayerConfiguration(bufferSize: 64 * 1024 * 1024));
    controller = VideoController(player);

    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeSmartStream());

    // �7�3 FIX 1: Accessing dimensions using 'w' and 'h' OR nullable check safety
    player.stream.videoParams.listen((params) {
      // Trying safe access if params.w/h exists, otherwise fallback to standard
      // Note: In media_kit, sometimes it's w/h, sometimes width/height depending on version.
      // We use 'w' and 'h' based on the error log you provided.
      final int? width = params.w; 
      final int? height = params.h;

      if (width != null && height != null && height > 0) {
        widget.onAspectRatioChanged(width / height);
      }
    });

    // RESET TO DEFAULT ON COMPLETE
    player.stream.completed.listen((completed) {
      if (completed) widget.onAspectRatioChanged(16 / 9);
    });

    player.stream.playing.listen((p) {
      if (p && _thumb && mounted) setState(() => _thumb = false);
      if (p) {
        _startRecordingProtection();
      } else {
        _stopRecordingProtection();
      }
    });

    player.stream.error.listen((event) {
      debugPrint("�7�2�1�5 Error: $event");
      _handleStreamFailure();
    });
  }

  Future<void> _initializeSmartStream() async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    String pref = provider.preferredQuality;
    if (pref == "Auto") {
      setState(() {
        _isAutoMode = true;
        _currentQualityLabel = "Auto";
      });
      await _autoSelectBestQualityAndLink();
    } else {
      setState(() {
        _isAutoMode = false;
        _currentQualityLabel = pref;
      });
      await _manualSelectQuality(pref);
    }
  }

  Future<void> _autoSelectBestQualityAndLink() async {
    var qModel = widget.sources.firstWhere((e) => e.quality == "1080p", orElse: () => widget.sources.first);
    _playUrl(await _findFastestLink(qModel.urls));
  }

  Future<void> _manualSelectQuality(String qualityLabel) async {
    var qModel = widget.sources.firstWhere((e) => e.quality == qualityLabel, orElse: () => widget.sources.first);
    _playUrl(await _findFastestLink(qModel.urls), keepPosition: true);
  }

  // �7�3 FIX 2: Correct logic for sorting and returning value (Void Fix)
  Future<String> _findFastestLink(List<String> urls) async {
    if (urls.isEmpty) return "";
    if (urls.length == 1) return urls.first;
    
    Map<String, int> latencies = {};
    await Future.wait(urls.map((url) async {
      try {
        final sw = Stopwatch()..start();
        await http.head(Uri.parse(url)).timeout(const Duration(seconds: 2));
        sw.stop();
        latencies[url] = sw.elapsedMilliseconds;
      } catch (e) {
        latencies[url] = 99999;
      }
    }));

    // Split sort logic to avoid void return error
    var entries = latencies.entries.toList();
    entries.sort((a, b) => a.value.compareTo(b.value));
    
    if (entries.isEmpty) return urls.first;
    return entries.first.key;
  }

  void _playUrl(String url, {bool keepPosition = false}) {
    if (url.isEmpty || url == _activeUrl) return;
    _activeUrl = url;
    Duration currentPos = player.state.position;
    // �7�3 HEADERS FOR CACHING
    player.open(Media(url, httpHeaders: {'Cache-Control': 'max-age=3600', 'Range': 'bytes=0-'}), play: true);
    if (keepPosition) Future.delayed(const Duration(milliseconds: 500), () => player.seek(currentPos));
  }

  void _handleStreamFailure() async {
    // Failover Logic placeholder
     var qModel = widget.sources.firstWhere((e) => e.quality == (_isAutoMode ? "1080p" : _currentQualityLabel), orElse: () => widget.sources.first);
    String? nextUrl;
    for (var u in qModel.urls) { if (u != _activeUrl) { nextUrl = u; break; } }
    if (nextUrl != null) { debugPrint("�9�4 Failover..."); _playUrl(nextUrl, keepPosition: true); }
  }

  void _startRecordingProtection() {
    _recordingTimer?.cancel();
    _recordingTimer = Timer(const Duration(minutes: 4, seconds: 53), () {
      if (mounted) setState(() => _blackScreen = true);
    });
  }

  void _stopRecordingProtection() {
    _recordingTimer?.cancel();
    if (_blackScreen) setState(() => _blackScreen = false);
  }

  void _closeAd() {
    if (mounted) {
      setState(() => _isAd = false);
      player.play();
    }
  }

  void _toggleLoop() {
    setState(() {
      _loop = !_loop;
      player.setPlaylistMode(_loop ? PlaylistMode.single : PlaylistMode.none);
    });
  }

  @override
  void dispose() {
    player.dispose();
    _recordingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.targetAspectRatio,
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          color: Colors.black,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _blackScreen
                  ? Container(
                      color: Colors.black,
                      child: const Center(child: Text("Protected", style: TextStyle(color: Colors.white))))
                  : Video(controller: controller, controls: NoVideoControls, fit: BoxFit.contain),
              if (widget.thumbnailUrl != null)
                AnimatedOpacity(
                  opacity: _thumb ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: IgnorePointer(
                    ignoring: !_thumb,
                    child: UniversalImage(path: widget.thumbnailUrl!, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                  ),
                ),
              if (!_isAd && _thumb && !player.state.playing)
                Center(
                    child: IconButton(
                        iconSize: 64,
                        icon: const Icon(Icons.play_circle_fill, color: Colors.white),
                        onPressed: () => player.play())),
              if (!_isAd && !_blackScreen) _controls(),
              if (!_isAd && _menuState != SettingsMenuState.none) _menu(constraints),
              if (_isAd)
                Positioned.fill(
                  child: SmartAdContainer(
                    adAspectRatio: widget.targetAspectRatio,
                    onClose: _closeAd,
                    externalUrl: "https://example.com",
                    adContent: ReliableAdLoader(
                        adUrl: "https://via.placeholder.com/600x340.png?text=AD",
                        adBuilder: (c, u) => Image.network(u, fit: BoxFit.cover)),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _controls() => Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
          color: Colors.black54,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SafeArea(
              top: false,
              child: Row(children: [
                IconButton(
                    icon: Icon(player.state.playing ? Icons.pause : Icons.play_arrow, color: Colors.white),
                    onPressed: player.playOrPause),
                IconButton(
                    icon: Icon(_loop ? Icons.repeat_one : Icons.repeat, color: _loop ? Colors.amber : Colors.white),
                    onPressed: _toggleLoop),
                const Spacer(),
                IconButton(
                    icon: Icon(Icons.settings, color: _menuState != SettingsMenuState.none ? Colors.amber : Colors.white),
                    onPressed: () => setState(() => _menuState = _menuState == SettingsMenuState.none
                        ? SettingsMenuState.main
                        : SettingsMenuState.none))
              ]))));

  Widget _menu(BoxConstraints c) => Positioned(
      bottom: 70,
      right: 20,
      child: Material(
          color: Colors.transparent,
          child: Container(
              width: min(280.0, c.maxWidth * 0.45),
              constraints: BoxConstraints(maxHeight: c.maxHeight * 0.6),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E).withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10)),
              child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: _buildMenuContent())))));

  // �7�3 FIX 3: Using the unused variables inside the menu logic to clear warnings
  List<Widget> _buildMenuContent() {
    if (_menuState == SettingsMenuState.main) {
      return [
        ListTile(
            dense: true,
            title: const Text("Speed", style: TextStyle(color: Colors.white)),
            onTap: () => setState(() => _menuState = SettingsMenuState.speed),
            trailing: const Icon(Icons.chevron_right, color: Colors.white)),
        const Divider(color: Colors.white10),
        ListTile(
            dense: true,
            title: const Text("Quality", style: TextStyle(color: Colors.white)),
            subtitle: Text(_currentQualityLabel, style: const TextStyle(color: Colors.amber, fontSize: 10)),
            onTap: () => setState(() => _menuState = SettingsMenuState.quality),
            trailing: const Icon(Icons.chevron_right, color: Colors.white)),
        const Divider(color: Colors.white10),
        ListTile(
            dense: true,
            title: const Text("AI Subtitles", style: TextStyle(color: Colors.white)),
            onTap: () => setState(() => _menuState = SettingsMenuState.subtitles),
            trailing: const Icon(Icons.chevron_right, color: Colors.white)),
      ];
    }
    
    if (_menuState == SettingsMenuState.speed) {
      return [
        ListTile(
            dense: true,
            title: const Text("Back", style: TextStyle(color: Colors.amber)),
            onTap: () => setState(() => _menuState = SettingsMenuState.main)),
        ...[0.5, 1.0, 1.5, 2.0].map((s) => ListTile(
            dense: true,
            title: Text("${s}x", style: TextStyle(color: player.state.rate == s ? Colors.amber : Colors.white)),
            onTap: () => setState(() {
                  player.setRate(s);
                })))
      ];
    }

    if (_menuState == SettingsMenuState.quality) {
       return [
        ListTile(
            dense: true,
            title: const Text("Back", style: TextStyle(color: Colors.amber)),
            onTap: () => setState(() => _menuState = SettingsMenuState.main)),
        ListTile(
            dense: true, 
            title: const Text("Auto", style: TextStyle(color: Colors.white)), 
            trailing: _isAutoMode ? const Icon(Icons.check, color: Colors.amber, size: 16) : null,
            onTap: () async {
               setState(() { _isAutoMode = true; _currentQualityLabel = "Auto"; });
               await Provider.of<AppProvider>(context, listen: false).setPreferredQuality("Auto");
               await _autoSelectBestQualityAndLink();
            }
        ),
        ...widget.sources.map((q) => ListTile(
            dense: true,
            title: Text(q.quality, style: TextStyle(color: Colors.white)),
            trailing: (!_isAutoMode && _currentQualityLabel == q.quality) ? const Icon(Icons.check, color: Colors.amber, size: 16) : null,
            onTap: () => setState(() {
                  _isAutoMode = false;
                  _currentQualityLabel = q.quality;
                  _manualSelectQuality(q.quality);
                })))
      ];
    }

    if (_menuState == SettingsMenuState.subtitles) {
      return [
        ListTile(
            dense: true,
            title: const Text("Back", style: TextStyle(color: Colors.amber)),
            onTap: () => setState(() => _menuState = SettingsMenuState.main)),
        SwitchListTile(
          value: _ai, 
          onChanged: (v) => setState(() => _ai = v), 
          title: const Text("Enable AI", style: TextStyle(color: Colors.white)),
          activeThumbColor: Colors.amber,
        ),
        if (_ai) ...[
          const Divider(color: Colors.white10),
          ..._aiLanguages.map((l) => ListTile(
            dense: true,
            title: Text(l, style: TextStyle(color: _currentAiLang == l ? Colors.amber : Colors.white)),
            onTap: () => setState(() => _currentAiLang = l),
          ))
        ]
      ];
    }

    return [];
  }
}