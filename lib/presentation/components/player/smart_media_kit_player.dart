import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/presentation/components/ads/ads_system.dart';

enum SettingsMenuState { none, main, speed, quality, subtitles, aiLanguages }

class SmartMediaKitPlayer extends StatefulWidget {
  final List<VideoQualityModel> sources;
  final String? thumbnailUrl;
  final Function(double ratio) onAspectRatioChanged;
  
  const SmartMediaKitPlayer({
    super.key,
    required this.sources,
    this.thumbnailUrl,
    required this.onAspectRatioChanged,
  });

  @override
  State<SmartMediaKitPlayer> createState() => _SmartMediaKitPlayerState();
}

class _SmartMediaKitPlayerState extends State<SmartMediaKitPlayer> {
  late final Player player;
  late final VideoController controller;
  SettingsMenuState _menuState = SettingsMenuState.none;
  StreamSubscription? _connectivitySub;

  bool _isAd = false;
  bool _thumb = true;
  bool _loop = false;
  bool _ai = false;
  bool _blackScreen = false;
  bool _isError = false; 
  bool _isIntervalAd = false; 
  bool _isFullscreen = false; 

  Timer? _recordingTimer;
  Timer? _intervalAdTimer; 

  String _currentAiLang = "English";
  String _currentQualityLabel = "Auto";
  String _activeUrl = "";
  bool _isAutoMode = true;
  final List<String> _aiLanguages = ["Arabic", "English", "Spanish", "French", "German"];

  double _currentRatio = 16/9;

  @override
  void initState() {
    super.initState();
    player = Player(configuration: const PlayerConfiguration(bufferSize: 64 * 1024 * 1024));
    controller = VideoController(player);

    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeSmartStream());
    
    _connectivitySub = Connectivity().onConnectivityChanged.listen((result) {
       if (_isError && !result.contains(ConnectivityResult.none)) {
         _retryPlayback();
       }
    });

    _intervalAdTimer = Timer.periodic(const Duration(minutes: 30), (timer) {
      if (player.state.playing && !_isIntervalAd && !_isAd) {
        _triggerIntervalAd();
      }
    });

    // Dynamic Aspect Ratio Logic
    player.stream.videoParams.listen((params) {
      final int? w = params.w; 
      final int? h = params.h;
      if (w != null && h != null && h > 0) {
        double newRatio = w / h;
        if ((newRatio - _currentRatio).abs() > 0.01) {
          setState(() { _currentRatio = newRatio; });
          widget.onAspectRatioChanged(newRatio);
        }
      }
    });

    player.stream.completed.listen((completed) {
      if (completed) {
         setState(() { _currentRatio = 16/9; });
         widget.onAspectRatioChanged(16/9);
      }
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
      setState(() => _isError = true);
      _handleStreamFailure();
    });
  }

  Future<void> _initializeSmartStream() async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    String pref = provider.preferredQuality;
    setState(() {
      _isAutoMode = pref == "Auto";
      _currentQualityLabel = pref;
    });
    if (_isAutoMode) {
      await _autoSelectBestQualityAndLink();
    } else {
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
      } catch (e) { latencies[url] = 99999; }
    }));
    var entries = latencies.entries.toList();
    entries.sort((a, b) => a.value.compareTo(b.value));
    return entries.isEmpty ? urls.first : entries.first.key;
  }

  void _playUrl(String url, {bool keepPosition = false}) {
    if (url.isEmpty || url == _activeUrl) return;
    _activeUrl = url;
    Duration currentPos = player.state.position;
    setState(() => _isError = false);
    player.open(Media(url, httpHeaders: {'Cache-Control': 'max-age=3600', 'Range': 'bytes=0-'}), play: true);
    if (keepPosition) Future.delayed(const Duration(milliseconds: 500), () => player.seek(currentPos));
  }

  void _retryPlayback() {
     _playUrl(_activeUrl, keepPosition: true);
  }

  void _handleStreamFailure() async { /* Failover logic */ }

  void _startRecordingProtection() {
    _recordingTimer?.cancel();
    _recordingTimer = Timer(const Duration(minutes: 4, seconds: 53), () {
      if (mounted) setState(() => _blackScreen = true);
    });
  }
  void _stopRecordingProtection() { _recordingTimer?.cancel(); if (_blackScreen) setState(() => _blackScreen = false); }

  void _toggleFullscreen() async {
    if (_isFullscreen) {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      setState(() => _isFullscreen = false);
    } else {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      if (_currentRatio >= 1) {
        await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      } else {
        await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      }
      setState(() => _isFullscreen = true);
    }
  }

  void _triggerIntervalAd() {
    if (!mounted) return;
    player.pause();
    setState(() => _isIntervalAd = true);
  }
  
  void _closeAd() {
    if (mounted) {
      setState(() { _isAd = false; _isIntervalAd = false; });
      player.play(); 
    }
  }

  @override
  void dispose() {
    player.dispose();
    _recordingTimer?.cancel();
    _intervalAdTimer?.cancel();
    _connectivitySub?.cancel();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _currentRatio,
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          color: Colors.black,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _blackScreen
                  ? Container(color: Colors.black, child: const Center(child: Text("Protected", style: TextStyle(color: Colors.white))))
                  : Video(controller: controller, controls: NoVideoControls, fit: BoxFit.contain),
              
              if (widget.thumbnailUrl != null)
                AnimatedOpacity(
                  opacity: _thumb ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: IgnorePointer(ignoring: !_thumb, child: UniversalImage(path: widget.thumbnailUrl!, fit: BoxFit.cover, width: double.infinity, height: double.infinity)),
                ),
                
              if (!_isAd && !_isIntervalAd && _thumb && !player.state.playing && !_isError)
                Center(child: IconButton(iconSize: 64, icon: const Icon(Icons.play_circle_fill, color: Colors.white), onPressed: () => player.play())),
                
              if (_isError)
                Positioned.fill(
                  child: Container(
                    color: Colors.black87,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wifi_off_rounded, color: Colors.redAccent, size: constraints.maxHeight * 0.2), 
                        SizedBox(height: constraints.maxHeight * 0.05),
                        Text("�1�8�1�6�1�7 �1�9�1�0�1�6�1�5�1�7 �1�7�1�2�1�3�1�9�1�8 �1�0�1�9�1�8�1�5�1�0�1�2�1�9�1�0�1�2", style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight * 0.06, fontWeight: FontWeight.bold)),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        ElevatedButton.icon(
                          onPressed: _retryPlayback, 
                          icon: Icon(Icons.refresh, size: constraints.maxHeight * 0.05), 
                          label: Text("�1�7�1�7�1�9�1�7�1�1 �1�9�1�5�1�9�1�2�1�8�1�1", style: TextStyle(fontSize: constraints.maxHeight * 0.04)),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.05, vertical: constraints.maxHeight * 0.02))
                        )
                      ],
                    ),
                  ),
                ),

              if (!_isAd && !_isIntervalAd && !_blackScreen && !_isError) _controls(),
              if (!_isAd && !_isIntervalAd && _menuState != SettingsMenuState.none) _menu(constraints),

              if (_isAd || _isIntervalAd)
                Positioned.fill(
                  child: SmartAdContainer(
                    adAspectRatio: _currentRatio,
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
      bottom: 0, left: 0, right: 0,
      child: Container(
          color: Colors.black54,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SafeArea(top: false, child: Row(children: [
                IconButton(icon: Icon(player.state.playing ? Icons.pause : Icons.play_arrow, color: Colors.white), onPressed: player.playOrPause),
                IconButton(icon: Icon(_loop ? Icons.repeat_one : Icons.repeat, color: _loop ? Colors.amber : Colors.white), onPressed: () => setState(() { _loop = !_loop; player.setPlaylistMode(_loop ? PlaylistMode.single : PlaylistMode.none); })),
                const Spacer(),
                IconButton(icon: Icon(_isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen, color: Colors.white), onPressed: _toggleFullscreen), 
                const SizedBox(width: 8),
                IconButton(icon: Icon(Icons.settings, color: _menuState != SettingsMenuState.none ? Colors.amber : Colors.white), onPressed: () => setState(() => _menuState = _menuState == SettingsMenuState.none ? SettingsMenuState.main : SettingsMenuState.none))
          ]))));

  Widget _menu(BoxConstraints c) => Positioned(bottom: 70, right: 20, child: Material(color: Colors.transparent, child: Container(width: min(280.0, c.maxWidth * 0.45), constraints: BoxConstraints(maxHeight: c.maxHeight * 0.6), padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF1E1E1E).withValues(alpha: 0.95), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)), child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: _buildMenuContent())))));

  List<Widget> _buildMenuContent() {
    if (_menuState == SettingsMenuState.main) {
      return [
        ListTile(dense: true, title: const Text("Speed", style: TextStyle(color: Colors.white)), onTap: () => setState(() => _menuState = SettingsMenuState.speed), trailing: const Icon(Icons.chevron_right, color: Colors.white)),
        const Divider(color: Colors.white10),
        ListTile(dense: true, title: const Text("Quality", style: TextStyle(color: Colors.white)), subtitle: Text(_currentQualityLabel, style: const TextStyle(color: Colors.amber, fontSize: 10)), onTap: () => setState(() => _menuState = SettingsMenuState.quality), trailing: const Icon(Icons.chevron_right, color: Colors.white)),
        const Divider(color: Colors.white10),
        ListTile(dense: true, title: const Text("AI Subtitles", style: TextStyle(color: Colors.white)), onTap: () => setState(() => _menuState = SettingsMenuState.subtitles), trailing: const Icon(Icons.chevron_right, color: Colors.white)),
      ];
    }
    if (_menuState == SettingsMenuState.speed) {
      return [ListTile(dense: true, title: const Text("Back", style: TextStyle(color: Colors.amber)), onTap: () => setState(() => _menuState = SettingsMenuState.main)), ...[0.5, 1.0, 1.5, 2.0].map((s) => ListTile(dense: true, title: Text("${s}x", style: TextStyle(color: player.state.rate == s ? Colors.amber : Colors.white)), onTap: () => setState(() { player.setRate(s); })))];
    }
    if (_menuState == SettingsMenuState.quality) {
       return [ListTile(dense: true, title: const Text("Back", style: TextStyle(color: Colors.amber)), onTap: () => setState(() => _menuState = SettingsMenuState.main)), ListTile(dense: true, title: const Text("Auto", style: TextStyle(color: Colors.white)), trailing: _isAutoMode ? const Icon(Icons.check, color: Colors.amber, size: 16) : null, onTap: () async { setState(() { _isAutoMode = true; _currentQualityLabel = "Auto"; }); await Provider.of<AppProvider>(context, listen: false).setPreferredQuality("Auto"); await _autoSelectBestQualityAndLink(); }), ...widget.sources.map((q) => ListTile(dense: true, title: Text(q.quality, style: TextStyle(color: Colors.white)), trailing: (!_isAutoMode && _currentQualityLabel == q.quality) ? const Icon(Icons.check, color: Colors.amber, size: 16) : null, onTap: () => setState(() { _isAutoMode = false; _currentQualityLabel = q.quality; _manualSelectQuality(q.quality); })))];
    }
    if (_menuState == SettingsMenuState.subtitles) {
      return [ListTile(dense: true, title: const Text("Back", style: TextStyle(color: Colors.amber)), onTap: () => setState(() => _menuState = SettingsMenuState.main)), SwitchListTile(value: _ai, onChanged: (v) => setState(() => _ai = v), title: const Text("Enable AI", style: TextStyle(color: Colors.white)), activeThumbColor: Colors.amber), if (_ai) ...[const Divider(color: Colors.white10), ..._aiLanguages.map((l) => ListTile(dense: true, title: Text(l, style: TextStyle(color: _currentAiLang == l ? Colors.amber : Colors.white)), onTap: () => setState(() => _currentAiLang = l)))]];
    }
    return [];
  }
}
