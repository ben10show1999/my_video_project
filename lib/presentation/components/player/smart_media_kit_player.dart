import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../core/components/universal_image.dart';
import '../../../data/models/movie_models.dart';
import '../../../core/logic/app_provider.dart';
import '../ads/ads_system.dart';

enum SettingsMenuState { none, main, speed, quality, subtitles, aiLanguages }

class SmartMediaKitPlayer extends StatefulWidget {
  final List<VideoQualityModel> sources; 
  final String? thumbnailUrl; 
  final double initialAspectRatio;
  // Callback for Fluid Layout in Desktop
  final Function(double)? onAspectRatioChanged; 

  const SmartMediaKitPlayer({super.key, required this.sources, this.thumbnailUrl, this.initialAspectRatio = 16/9, this.onAspectRatioChanged});
  @override State<SmartMediaKitPlayer> createState() => _SmartMediaKitPlayerState();
}

class _SmartMediaKitPlayerState extends State<SmartMediaKitPlayer> {
  late final Player player; late final VideoController controller;
  SettingsMenuState _menuState = SettingsMenuState.none;
  
  bool _isAd = false; bool _thumb = true; bool _loop = false; bool _ai = false;
  bool _blackScreen = false; Timer? _recordingTimer;
  String _currentAiLang = "English";
  
  // Network & Quality
  String _currentQualityLabel = "Auto"; String _activeUrl = ""; bool _isAutoMode = true;
  
  // �7�3 TASK 5: Adaptive Aspect Ratio State
  double _currentAspectRatio = 16/9;

  // �7�3 TASK 7: Error Recovery State
  bool _isError = false;
  StreamSubscription? _connectivitySub;

  final List<String> _aiLanguages = ["Arabic", "English", "Spanish", "French", "German"];

  @override void initState() {
    super.initState(); 
    _currentAspectRatio = widget.initialAspectRatio;

    // �7�3 TASK 4: Aggressive Buffering (64MB)
    player = Player(configuration: const PlayerConfiguration(bufferSize: 64 * 1024 * 1024)); 
    controller = VideoController(player);
    
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeSmartStream());

    // Listener for Aspect Ratio Changes (Dynamic Adaptation)
    player.stream.videoParams.listen((params) {
      if (params.aspect != null && params.aspect! > 0) {
        if ((params.aspect! - _currentAspectRatio).abs() > 0.01) {
          setState(() => _currentAspectRatio = params.aspect!);
          // Notify parent for desktop layout adjustment
          widget.onAspectRatioChanged?.call(_currentAspectRatio);
        }
      }
    });

    // Reset Ratio on Completion
    player.stream.completed.listen((_) {
      if (mounted) setState(() => _currentAspectRatio = 16/9);
      widget.onAspectRatioChanged?.call(16/9);
    });

    player.stream.playing.listen((p) { 
      if (p && _thumb && mounted) setState(() => _thumb = false); 
      if (p) {
        _startRecordingProtection();
      } else {
        _stopRecordingProtection();
      }
      if (p && _isError) setState(() => _isError = false); // Clear error on play
    });

    player.stream.error.listen((event) {
      debugPrint("�7�2�1�5 Stream Error Detected: $event.");
      _handleStreamFailure();
    });

    // �7�3 TASK 7: Connectivity Auto-Resume
    _connectivitySub = Connectivity().onConnectivityChanged.listen((result) {
      if (_isError && !result.contains(ConnectivityResult.none)) {
        debugPrint("�9�0 Internet Restored. Auto-Retrying playback...");
        _retryPlayback();
      }
    });
  }

  Future<void> _initializeSmartStream() async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    String pref = provider.preferredQuality; 

    if (pref == "Auto") {
      _isAutoMode = true; _currentQualityLabel = "Auto";
      await _autoSelectBestQualityAndLink();
    } else {
      _isAutoMode = false; _currentQualityLabel = pref;
      await _manualSelectQuality(pref);
    }
  }

  Future<void> _autoSelectBestQualityAndLink() async {
    String targetQuality = "1080p"; 
    var qModel = widget.sources.firstWhere((e) => e.quality == targetQuality, orElse: () => widget.sources.first);
    String bestUrl = await _findFastestLink(qModel.urls);
    _playUrl(bestUrl);
  }

  Future<void> _manualSelectQuality(String qualityLabel) async {
    var qModel = widget.sources.firstWhere((e) => e.quality == qualityLabel, orElse: () => widget.sources.first);
    String bestUrl = await _findFastestLink(qModel.urls);
    _playUrl(bestUrl, keepPosition: true);
  }

  Future<String> _findFastestLink(List<String> urls) async {
    if (urls.isEmpty) return "";
    if (urls.length == 1) return urls.first;
    Map<String, int> latencies = {};
    await Future.wait(urls.map((url) async {
      try {
        final stopwatch = Stopwatch()..start();
        await http.head(Uri.parse(url)).timeout(const Duration(seconds: 2)); 
        stopwatch.stop();
        latencies[url] = stopwatch.elapsedMilliseconds;
      } catch (e) { latencies[url] = 99999; }
    }));
    var sorted = latencies.entries.toList()..sort((a, b) => a.value.compareTo(b.value));
    return sorted.first.key;
  }

  void _playUrl(String url, {bool keepPosition = false}) {
    if (url.isEmpty || url == _activeUrl) return;
    _activeUrl = url;
    Duration currentPos = player.state.position;
    
    // �7�3 TASK 5: Local Cache Headers
    player.open(Media(url, httpHeaders: {
      'Cache-Control': 'max-age=3600', 
      'Range': 'bytes=0-'
    }), play: true);
    
    if (keepPosition) {
      Future.delayed(const Duration(milliseconds: 500), () => player.seek(currentPos));
    }
    setState(() => _isError = false);
  }

  void _handleStreamFailure() async {
    // Try failover first
    var qModel = widget.sources.firstWhere((e) => e.quality == (_isAutoMode ? "1080p" : _currentQualityLabel), orElse: () => widget.sources.first);
    String? nextUrl;
    for (var u in qModel.urls) {
      if (u != _activeUrl) { nextUrl = u; break; }
    }
    if (nextUrl != null) {
      debugPrint("�9�4 Failover: Switching to backup link...");
      _playUrl(nextUrl, keepPosition: true);
    } else {
      debugPrint("�7�4 Critical: All links failed or No Internet.");
      if (mounted) setState(() => _isError = true);
    }
  }

  void _retryPlayback() {
    setState(() => _isError = false);
    if (_activeUrl.isNotEmpty) {
      _playUrl(_activeUrl, keepPosition: true);
    } else {
      _initializeSmartStream();
    }
  }

  void _startRecordingProtection() { _recordingTimer?.cancel(); _recordingTimer = Timer(const Duration(minutes: 4, seconds: 53), () { if (mounted) setState(() => _blackScreen = true); }); }
  void _stopRecordingProtection() { _recordingTimer?.cancel(); if(_blackScreen) setState(()=>_blackScreen=false); }
  void _closeAd() { if (mounted) { setState(() => _isAd = false); player.play(); } }
  void _toggleLoop() { setState(() { _loop = !_loop; player.setPlaylistMode(_loop ? PlaylistMode.single : PlaylistMode.none); }); }
  @override void dispose() { player.dispose(); _recordingTimer?.cancel(); _connectivitySub?.cancel(); super.dispose(); }

  @override Widget build(BuildContext context) {
    // �7�3 TASK 5: Dynamic Aspect Ratio Widget
    return AspectRatio(
      aspectRatio: _currentAspectRatio, 
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(color: Colors.black, child: Stack(alignment: Alignment.center, children: [
          _blackScreen ? Container(color: Colors.black, child: const Center(child: Text("Recording Protected", style: TextStyle(color: Colors.white)))) : Video(controller: controller, controls: NoVideoControls, fit: BoxFit.contain),
          if (widget.thumbnailUrl != null) AnimatedOpacity(opacity: _thumb ? 1.0 : 0.0, duration: const Duration(milliseconds: 500), child: IgnorePointer(ignoring: !_thumb, child: UniversalImage(path: widget.thumbnailUrl!, fit: BoxFit.cover, width: double.infinity, height: double.infinity))),
          if (!_isAd && _thumb && !player.state.playing && !_isError) Center(child: IconButton(iconSize: 64, icon: const Icon(Icons.play_circle_fill, color: Colors.white), onPressed: () => player.play())),
          if (!_isAd && !_blackScreen && !_isError) _controls(),
          if (!_isAd && _menuState != SettingsMenuState.none) _menu(constraints),
          
          // �7�3 TASK 7: Error Overlay UI
          if (_isError) Container(
            color: Colors.black87,
            child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.wifi_off, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              const Text("�1�8�1�6�1�7 �1�9�1�0�1�6�1�5�1�7 �1�7�1�2�1�3�1�9�1�8 �1�0�1�9�1�8�1�5�1�0�1�2�1�9�1�0�1�2", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _retryPlayback, 
                icon: const Icon(Icons.refresh), 
                label: const Text("�1�7�1�7�1�9�1�7�1�1 �1�9�1�5�1�9�1�2�1�8�1�1"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black)
              )
            ])),
          ),

          if (_isAd) Positioned.fill(child: Container(color: Colors.black87, child: Center(child: SizedBox(width: 600, child: SmartAdContainer(adAspectRatio: 16/9, onClose: _closeAd, externalUrl: "https://example.com", adContent: ReliableAdLoader(adUrl: "https://via.placeholder.com/600x340.png?text=AD", adBuilder: (c, u) => Image.network(u, fit: BoxFit.cover))))))),
        ]));
      })
    );
  }

  Widget _controls() => Positioned(bottom: 0, left: 0, right: 0, child: Container(color: Colors.black54, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: SafeArea(top: false, child: Row(children: [IconButton(icon: Icon(player.state.playing ? Icons.pause : Icons.play_arrow, color: Colors.white), onPressed: player.playOrPause), IconButton(icon: Icon(_loop ? Icons.repeat_one : Icons.repeat, color: _loop ? Colors.amber : Colors.white), onPressed: _toggleLoop), const Spacer(), IconButton(icon: Icon(Icons.settings, color: _menuState != SettingsMenuState.none ? Colors.amber : Colors.white), onPressed: () => setState(() => _menuState = _menuState == SettingsMenuState.none ? SettingsMenuState.main : SettingsMenuState.none))]))));

  Widget _menu(BoxConstraints playerConstraints) {
    final double menuWidth = min(280.0, max(200.0, playerConstraints.maxWidth * 0.45));
    return Positioned(
      bottom: 70, right: 20, 
      child: Material(color: Colors.transparent, child: Container(
        width: menuWidth, constraints: BoxConstraints(maxHeight: playerConstraints.maxHeight * 0.6),
        padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF1E1E1E).withValues(alpha: 0.95), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)), 
        child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: _buildMenuContent()))
      ))
    );
  }

  List<Widget> _buildMenuContent() {
    switch (_menuState) {
      case SettingsMenuState.main: return [
        ListTile(dense: true, title: const Text("Speed", style: TextStyle(color: Colors.white)), onTap: () => setState(() => _menuState = SettingsMenuState.speed), trailing: const Icon(Icons.chevron_right, color: Colors.white)),
        const Divider(color: Colors.white10),
        ListTile(dense: true, title: const Text("Subtitles", style: TextStyle(color: Colors.white)), onTap: () => setState(() => _menuState = SettingsMenuState.subtitles), trailing: const Icon(Icons.chevron_right, color: Colors.white)),
        if (widget.sources.length > 1) ...[
          const Divider(color: Colors.white10),
          ListTile(dense: true, title: const Text("Quality", style: TextStyle(color: Colors.white)), subtitle: Text(_currentQualityLabel, style: const TextStyle(color: Colors.amber, fontSize: 10)), onTap: () => setState(() => _menuState = SettingsMenuState.quality), trailing: const Icon(Icons.chevron_right, color: Colors.white)),
        ]
      ];
      case SettingsMenuState.speed: return [
        InkWell(onTap: () => setState(() => _menuState = SettingsMenuState.main), child: Padding(padding: const EdgeInsets.all(8.0), child: Row(children: const [Icon(Icons.arrow_back, color: Colors.white, size: 16), SizedBox(width: 8), Text("Speed", style: TextStyle(color: Colors.white))]))),
        ...[0.5, 1.0, 1.5, 2.0].map((s) => ListTile(dense: true, title: Text("${s}x", style: TextStyle(color: player.state.rate == s ? Colors.amber : Colors.white)), onTap: () { player.setRate(s); setState((){}); }))
      ];
      case SettingsMenuState.quality: return [
        InkWell(onTap: () => setState(() => _menuState = SettingsMenuState.main), child: Padding(padding: const EdgeInsets.all(8.0), child: Row(children: const [Icon(Icons.arrow_back, color: Colors.white, size: 16), SizedBox(width: 8), Text("Quality", style: TextStyle(color: Colors.white))]))),
        ListTile(dense: true, title: const Text("Auto", style: TextStyle(color: Colors.white)), trailing: _isAutoMode ? const Icon(Icons.check, color: Colors.amber, size: 16) : null, onTap: () async { setState(() { _isAutoMode = true; _currentQualityLabel = "Auto"; }); await Provider.of<AppProvider>(context, listen: false).setPreferredQuality("Auto"); await _autoSelectBestQualityAndLink(); }),
        const Divider(color: Colors.white10),
        ...widget.sources.map((q) => ListTile(dense: true, title: Text(q.quality, style: TextStyle(color: (!_isAutoMode && _currentQualityLabel == q.quality) ? Colors.amber : Colors.white)), onTap: () async { setState(() { _isAutoMode = false; _currentQualityLabel = q.quality; }); await Provider.of<AppProvider>(context, listen: false).setPreferredQuality(q.quality); await _manualSelectQuality(q.quality); }))
      ];
      case SettingsMenuState.subtitles: return [
        InkWell(onTap: () => setState(() => _menuState = SettingsMenuState.main), child: Padding(padding: const EdgeInsets.all(8.0), child: Row(children: const [Icon(Icons.arrow_back, color: Colors.white, size: 16), SizedBox(width: 8), Text("Subtitles", style: TextStyle(color: Colors.white))]))),
        SwitchListTile(value: _ai, onChanged: (v) => setState(() => _ai = v), title: const Text("AI Translate", style: TextStyle(color: Colors.white, fontSize: 13)), activeThumbColor: Colors.amber),
        const Divider(color: Colors.white10),
        if (_ai) ...[
          ListTile(dense: true, title: Text("Language: $_currentAiLang", style: const TextStyle(color: Colors.amber)), onTap: () => setState(() => _menuState = SettingsMenuState.aiLanguages), trailing: const Icon(Icons.chevron_right, color: Colors.white)),
        ] else ...[
          ListTile(dense: true, title: Text("Off", style: TextStyle(color: player.state.track.subtitle == SubtitleTrack.no() ? Colors.amber : Colors.white)), onTap: () { player.setSubtitleTrack(SubtitleTrack.no()); setState((){}); }),
          ...player.state.tracks.subtitle.where((e) => e != SubtitleTrack.no()).map((e) => ListTile(dense: true, title: Text(e.title ?? e.language ?? "Unknown", style: TextStyle(color: player.state.track.subtitle == e ? Colors.amber : Colors.white)), onTap: () { player.setSubtitleTrack(e); setState((){}); }))
        ]
      ];
      case SettingsMenuState.aiLanguages: return [
         InkWell(onTap: () => setState(() => _menuState = SettingsMenuState.subtitles), child: Padding(padding: const EdgeInsets.all(8.0), child: Row(children: const [Icon(Icons.arrow_back, color: Colors.white, size: 16), SizedBox(width: 8), Text("Select Language", style: TextStyle(color: Colors.white))]))),
         ..._aiLanguages.map((l) => ListTile(dense: true, title: Text(l, style: TextStyle(color: _currentAiLang == l ? Colors.amber : Colors.white)), onTap: () => setState(() { _currentAiLang = l; _menuState = SettingsMenuState.subtitles; })))
      ];
      default: return [];
    }
  }
}
