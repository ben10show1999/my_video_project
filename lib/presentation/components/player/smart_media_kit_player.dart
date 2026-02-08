import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/presentation/components/ads/ads_system.dart';

enum SettingsMenuState { none, main, speed, quality, subtitles }

class SmartMediaKitPlayer extends StatefulWidget {
  final List<VideoQualityModel> sources;
  final String? thumbnailUrl;
  final Function(double ratio) onAspectRatioChanged;
  const SmartMediaKitPlayer({super.key, required this.sources, this.thumbnailUrl, required this.onAspectRatioChanged});
  @override State<SmartMediaKitPlayer> createState() => _SmartMediaKitPlayerState();
}

class _SmartMediaKitPlayerState extends State<SmartMediaKitPlayer> {
  late final Player player; late final VideoController controller;
  SettingsMenuState _menuState = SettingsMenuState.none;
  bool _isAd = false; bool _thumb = true; bool _loop = false; bool _ai = false; 
  bool _muted = false;
  
  bool _isBlocked = false; 
  Timer? _activeTimer; Timer? _cooldownTimer; 
  final Duration _protectionLimit = const Duration(minutes: 4, seconds: 53);

  bool _isError = false; bool _isIntervalAd = false; bool _isFullscreen = false;
  Timer? _intervalAdTimer;
  
  bool _showControls = true;
  Timer? _hideTimer;

  double _currentSliderValue = 0.0;
  bool _isDragging = false;

  String _currentQualityLabel = "Auto"; 
  String _activeUrl = ""; 
  bool _isAutoMode = true; 
  double _currentRatio = 16/9;

  // Task 37: Keyboard Focus Node
  final FocusNode _focusNode = FocusNode();

  @override void initState() {
    super.initState();
    // bufferSize handles the aggressive caching intent without crashing
    player = Player(configuration: const PlayerConfiguration(bufferSize: 32 * 1024 * 1024));

    controller = VideoController(player);
    
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      _initializeSmartStream();
      _focusNode.requestFocus(); // Auto focus for keyboard
    });
    
    Connectivity().onConnectivityChanged.listen((result) { if (_isError && !result.contains(ConnectivityResult.none)) _retryPlayback(); });
    
    _intervalAdTimer = Timer.periodic(const Duration(minutes: 30), (timer) { if (player.state.playing && !_isIntervalAd && !_isAd && !_isBlocked) _triggerIntervalAd(); });
    
    player.stream.videoParams.listen((params) { 
      final w = params.w; final h = params.h; 
      if (w != null && h != null && h > 0) { 
        double nr = w / h; 
        if ((nr - _currentRatio).abs() > 0.01) { 
          setState(() => _currentRatio = nr); 
          widget.onAspectRatioChanged(nr); 
        } 
      } 
    });

    player.stream.completed.listen((c) {
      if (c) {
        setState(() => _currentRatio = 16/9);
        widget.onAspectRatioChanged(16/9);
        _resetHideTimer(); 
      }
    });
    
    player.stream.playing.listen((p) { 
      if (p) {
        if (_thumb && mounted) setState(() => _thumb = false); 
        _startActiveTimer();
        _resetHideTimer(); 
      } else {
        _pauseActiveTimer();
        setState(() => _showControls = true); 
      }
    });
    
    player.stream.error.listen((e) { 
      _attemptFailover();
    });

    _resetHideTimer();
  }

  void _resetHideTimer() {
    _hideTimer?.cancel();
    if (!mounted) return;
    setState(() => _showControls = true);
    if (player.state.playing && !_isDragging) {
      _hideTimer = Timer(const Duration(seconds: 3), () {
        if (mounted && player.state.playing && !_isDragging) {
          setState(() => _showControls = false);
        }
      });
    }
  }

  void _onUserInteraction() {
    _resetHideTimer();
  }

  void _startActiveTimer() { if (_isBlocked) return; _activeTimer?.cancel(); _activeTimer = Timer(_protectionLimit, _triggerBlock); }
  void _pauseActiveTimer() { _activeTimer?.cancel(); }
  void _triggerBlock() { if (!mounted) return; player.pause(); setState(() => _isBlocked = true); _cooldownTimer?.cancel(); _cooldownTimer = Timer(_protectionLimit, _releaseBlock); }
  void _releaseBlock() { if (!mounted) return; setState(() => _isBlocked = false); player.play(); _startActiveTimer(); }

  Future<void> _initializeSmartStream() async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    String pref = provider.preferredQuality;
    setState(() { _isAutoMode = pref == "Auto"; _currentQualityLabel = pref; });
    
    if (_isAutoMode) {
      await _smartSelectQuality("1080p", fallback: true);
    } else {
      await _smartSelectQuality(pref, fallback: false);
    }
  }

  Future<void> _smartSelectQuality(String q, {bool fallback = false}) async {
    var qm = widget.sources.firstWhere((e) => e.quality == q, orElse: () => widget.sources.first);
    if (qm.urls.isNotEmpty) {
        _playUrl(qm.urls.first, keepPosition: true);
    } else if (fallback) {
       _attemptFailover();
    }
  }

  void _attemptFailover() {
     if (_currentQualityLabel == "1080p") {
        debugPrint("Failover: 1080p failed, trying 480p");
        setState(() => _currentQualityLabel = "480p");
        _smartSelectQuality("480p", fallback: true);
     } else if (_currentQualityLabel == "480p") {
        debugPrint("Failover: 480p failed, trying 240p");
        setState(() => _currentQualityLabel = "240p");
        _smartSelectQuality("240p", fallback: true);
     } else {
        setState(() => _isError = true);
     }
  }

  void _playUrl(String url, {bool keepPosition = false}) { 
    if (url.isEmpty || url == _activeUrl) return; 
    _activeUrl = url; 
    Duration c = player.state.position; 
    setState(() => _isError = false); 
    player.open(Media(url, httpHeaders: {'Cache-Control': 'max-age=3600'}), play: true); 
    if (keepPosition && c.inSeconds > 0) Future.delayed(const Duration(milliseconds: 500), () => player.seek(c)); 
  }

  void _retryPlayback() { _playUrl(_activeUrl, keepPosition: true); }
  
  void _toggleFullscreen() async { 
    if (_isFullscreen) { 
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); 
      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); 
      setState(() => _isFullscreen = false); 
    } else { 
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); 
      if (_currentRatio >= 1) {
        await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
      } else {
        await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      } 
      setState(() => _isFullscreen = true); 
    } 
  }
  
  void _triggerIntervalAd() { if (!mounted) return; player.pause(); setState(() => _isIntervalAd = true); }
  void _closeAd() { if (mounted) { setState(() { _isAd = false; _isIntervalAd = false; }); player.play(); } }
  
  // Task 37: Keyboard Actions
  void _seekRelative(Duration d) {
    final pos = player.state.position;
    final dur = player.state.duration;
    var newPos = pos + d;
    if (newPos < Duration.zero) newPos = Duration.zero;
    if (newPos > dur) newPos = dur;
    player.seek(newPos);
    _onUserInteraction();
  }
  
  void _toggleMute() {
    setState(() => _muted = !_muted);
    player.setVolume(_muted ? 0 : 100);
  }
  
  @override void dispose() { player.dispose(); _activeTimer?.cancel(); _cooldownTimer?.cancel(); _intervalAdTimer?.cancel(); _hideTimer?.cancel(); _focusNode.dispose(); super.dispose(); }

  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context); 
    
    // Task 37: Keyboard Listener
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.space): () => player.playOrPause(),
        const SingleActivator(LogicalKeyboardKey.keyK): () => player.playOrPause(),
        const SingleActivator(LogicalKeyboardKey.keyJ): () => _seekRelative(const Duration(seconds: -10)),
        const SingleActivator(LogicalKeyboardKey.keyL): () => _seekRelative(const Duration(seconds: 10)),
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () => _seekRelative(const Duration(seconds: -5)),
        const SingleActivator(LogicalKeyboardKey.arrowRight): () => _seekRelative(const Duration(seconds: 5)),
        const SingleActivator(LogicalKeyboardKey.keyF): () => _toggleFullscreen(),
        const SingleActivator(LogicalKeyboardKey.keyM): () => _toggleMute(),
      },
      child: Focus(
        focusNode: _focusNode,
        autofocus: true,
        child: MouseRegion(
          onHover: (_) => _onUserInteraction(),
          cursor: _showControls ? SystemMouseCursors.basic : SystemMouseCursors.none,
          child: GestureDetector(
            onTap: () {
                _focusNode.requestFocus(); // Ensure focus on tap
                setState(() => _showControls = !_showControls);
                if (_showControls) _resetHideTimer();
            },
            child: AspectRatio(aspectRatio: _currentRatio, child: LayoutBuilder(builder: (c, cs) { 
              return Container(color: Colors.black, child: Stack(alignment: Alignment.center, children: [
                _isBlocked ? Container(color: Colors.black, width: double.infinity, height: double.infinity, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.lock_clock, color: Colors.white54, size: 50), const SizedBox(height: 16), Text(p.tr('protected'), style: const TextStyle(color: Colors.white, fontSize: 18)), Text(p.tr('wait_msg'), style: const TextStyle(color: Colors.white54))])) : Video(controller: controller, controls: NoVideoControls, fit: BoxFit.contain),
                
                if (widget.thumbnailUrl != null) AnimatedOpacity(opacity: _thumb ? 1.0 : 0.0, duration: const Duration(milliseconds: 500), child: IgnorePointer(ignoring: !_thumb, child: UniversalImage(path: widget.thumbnailUrl!, fit: BoxFit.cover, width: double.infinity, height: double.infinity))), 
                if (!_isAd && !_isIntervalAd && _thumb && !player.state.playing && !_isError) Center(child: IconButton(iconSize: 64, icon: const Icon(Icons.play_circle_fill, color: Colors.white), onPressed: () => player.play())), 
                
                if (player.state.buffering) const Center(child: CircularProgressIndicator(color: Colors.amber)),

                if (_isError) Positioned.fill(child: Container(color: Colors.black87, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.wifi_off, color: Colors.red, size: 50), Text(p.tr('connection_error'), style: const TextStyle(color: Colors.white)), ElevatedButton(onPressed: _retryPlayback, child: Text(p.tr('retry')))]))), 
                
                if (!_isAd && !_isIntervalAd && !_isBlocked && !_isError) 
                  AnimatedOpacity(opacity: _showControls ? 1.0 : 0.0, duration: const Duration(milliseconds: 300), child: IgnorePointer(ignoring: !_showControls, child: _controls())), 
                
                if (!_isAd && !_isIntervalAd && _menuState != SettingsMenuState.none) _menu(cs, p), 
                
                if (_isAd || _isIntervalAd) Positioned.fill(child: SmartAdContainer(adAspectRatio: _currentRatio, onClose: _closeAd, adContent: ReliableAdLoader(adUrl: "https://via.placeholder.com/600x340.png?text=AD", adBuilder: (c, u) => Image.network(u, fit: BoxFit.cover))))
              ])); 
            })),
          ),
        ),
      ),
    ); 
  }

  Widget _controls() {
    return Positioned(bottom: 0, left: 0, right: 0, child: Container(color: Colors.black54, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: SafeArea(top: false, child: Column(mainAxisSize: MainAxisSize.min, children: [
      StreamBuilder<Duration>(
        stream: player.stream.position,
        builder: (context, snapshot) {
          final pos = snapshot.data ?? Duration.zero;
          final duration = player.state.duration;
          double max = duration.inMilliseconds.toDouble();
          double val = pos.inMilliseconds.toDouble();
          if (val > max) val = max;
          if (_isDragging) val = _currentSliderValue;

          return Row(children: [
             Text(_formatDuration(pos), style: const TextStyle(color: Colors.white, fontSize: 12)),
             Expanded(child: Slider(
               value: val, 
               min: 0, 
               max: max > 0 ? max : 1.0, 
               activeColor: Colors.amber,
               inactiveColor: Colors.white24,
               onChangeStart: (v) => _isDragging = true,
               onChanged: (v) => setState(() => _currentSliderValue = v),
               onChangeEnd: (v) { _isDragging = false; player.seek(Duration(milliseconds: v.toInt())); },
             )),
             Text(_formatDuration(duration), style: const TextStyle(color: Colors.white, fontSize: 12)),
          ]);
        }
      ),
      Row(children: [
        StreamBuilder<bool>(
          stream: player.stream.playing,
          builder: (c, s) => IconButton(icon: Icon(s.data == true ? Icons.pause : Icons.play_arrow, color: Colors.white), onPressed: player.playOrPause)
        ),
        IconButton(icon: Icon(_loop ? Icons.repeat_one : Icons.repeat, color: _loop ? Colors.amber : Colors.white), onPressed: () => setState(() { _loop = !_loop; player.setPlaylistMode(_loop ? PlaylistMode.single : PlaylistMode.none); })), 
        IconButton(icon: Icon(_muted ? Icons.volume_off : Icons.volume_up, color: Colors.white), onPressed: _toggleMute), // Added Mute Icon
        const Spacer(), 
        IconButton(icon: Icon(_isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen, color: Colors.white), onPressed: _toggleFullscreen), 
        const SizedBox(width: 8), 
        IconButton(icon: Icon(Icons.settings, color: _menuState != SettingsMenuState.none ? Colors.amber : Colors.white), onPressed: () => setState(() => _menuState = _menuState == SettingsMenuState.none ? SettingsMenuState.main : SettingsMenuState.none))
      ])
    ]))));
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(d.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(d.inSeconds.remainder(60));
    if (d.inHours > 0) return "${twoDigits(d.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget _menu(BoxConstraints c, AppProvider p) => Positioned(bottom: 90, right: 20, child: Material(color: Colors.transparent, child: Container(width: min(280.0, c.maxWidth * 0.45), constraints: BoxConstraints(maxHeight: c.maxHeight * 0.6), padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF1E1E1E).withValues(alpha: 0.95), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)), child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: _buildMenuContent(p))))));
  
  List<Widget> _buildMenuContent(AppProvider p) {
    if (_menuState == SettingsMenuState.main) {
      return [
      ListTile(dense: true, title: Text(p.tr('speed'), style: const TextStyle(color: Colors.white)), onTap: () => setState(() => _menuState = SettingsMenuState.speed), trailing: const Icon(Icons.chevron_right, color: Colors.white)), 
      const Divider(color: Colors.white10), 
      ListTile(dense: true, title: Text(p.tr('quality'), style: const TextStyle(color: Colors.white)), subtitle: Text(_currentQualityLabel, style: const TextStyle(color: Colors.amber, fontSize: 10)), onTap: () => setState(() => _menuState = SettingsMenuState.quality), trailing: const Icon(Icons.chevron_right, color: Colors.white)),
      const Divider(color: Colors.white10),
      ListTile(dense: true, title: Text(p.tr('subtitles'), style: const TextStyle(color: Colors.white)), onTap: () => setState(() => _menuState = SettingsMenuState.subtitles), trailing: const Icon(Icons.chevron_right, color: Colors.white)),
    ];
    }
    if (_menuState == SettingsMenuState.speed) return [ListTile(dense: true, title: Text(p.tr('back'), style: const TextStyle(color: Colors.amber)), onTap: () => setState(() => _menuState = SettingsMenuState.main)), ...[0.5, 1.0, 1.5, 2.0].map((s) => ListTile(dense: true, title: Text("${s}x", style: TextStyle(color: player.state.rate == s ? Colors.amber : Colors.white)), onTap: () => setState(() { player.setRate(s); })))];
    
    if (_menuState == SettingsMenuState.quality) {
      return [
      ListTile(dense: true, title: Text(p.tr('back'), style: const TextStyle(color: Colors.amber)), onTap: () => setState(() => _menuState = SettingsMenuState.main)), 
      ListTile(dense: true, title: Text(p.tr('auto'), style: const TextStyle(color: Colors.white)), trailing: _isAutoMode ? const Icon(Icons.check, color: Colors.amber, size: 16) : null, onTap: () async { setState(() { _isAutoMode = true; _currentQualityLabel = "Auto"; }); await p.setPreferredQuality("Auto"); await _initializeSmartStream(); }), 
      ...widget.sources.map((q) => ListTile(dense: true, title: Text(q.quality, style: TextStyle(color: Colors.white)), trailing: (!_isAutoMode && _currentQualityLabel == q.quality) ? const Icon(Icons.check, color: Colors.amber, size: 16) : null, onTap: () => setState(() { _isAutoMode = false; _currentQualityLabel = q.quality; _smartSelectQuality(q.quality); })))
    ];
    }
    
    if (_menuState == SettingsMenuState.subtitles) return [ListTile(dense: true, title: Text(p.tr('back'), style: const TextStyle(color: Colors.amber)), onTap: () => setState(() => _menuState = SettingsMenuState.main)), SwitchListTile(value: _ai, onChanged: (v) => setState(() => _ai = v), title: Text(p.tr('enable_ai'), style: const TextStyle(color: Colors.white)), activeThumbColor: Colors.amber)];
    return [];
  }
}
