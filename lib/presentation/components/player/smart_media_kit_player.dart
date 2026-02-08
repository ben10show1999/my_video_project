import 'dart:async';
import 'dart:math';
// FIX 5: For debugPrint
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
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
  late final Player player; 
  late final VideoController controller;
  
  // UI States
  SettingsMenuState _menuState = SettingsMenuState.none;
  bool _isAd = false; 
  bool _thumb = true; 
  bool _controlsVisible = true; 
  Timer? _hideTimer;
  bool _isPlaying = false; 

  // Cyclic Protection
  bool _isBlocked = false; 
  Timer? _activeTimer; Timer? _cooldownTimer; 
  final Duration _protectionLimit = const Duration(minutes: 4, seconds: 53);

  bool _isError = false; 
  
  // Logic States
  String _currentQualityLabel = "Auto"; 
  String _activeUrl = ""; 
  bool _isAutoMode = true; 
  double _currentRatio = 16/9;

  @override void initState() {
    super.initState();
    // FIX 3 & 4: Removed player.setProperty calls.
    // Relying on bufferSize for aggressive preloading.
    player = Player(configuration: const PlayerConfiguration(
      bufferSize: 100 * 1024 * 1024, // 100MB Buffer
      vo: 'gpu', 
    ));
    
    controller = VideoController(player);
    
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeSmartStream());
    
    player.stream.playing.listen((p) {
      if (mounted) setState(() { _isPlaying = p; if (p) _thumb = false; });
      if (p) { _startActiveTimer(); _startHideTimer(); } else { _pauseActiveTimer(); _showControls(); }
    });

    player.stream.error.listen((e) { 
      // FIX 5: Use debugPrint
      debugPrint("Player Error: $e");
      setState(() => _isError = true);
    });

    player.stream.videoParams.listen((params) { 
      if (params.w != null && params.h != null && params.h! > 0) { 
        double nr = params.w! / params.h!; 
        if ((nr - _currentRatio).abs() > 0.01) { 
          setState(() => _currentRatio = nr); 
          widget.onAspectRatioChanged(nr); 
        } 
      } 
    });

    player.stream.completed.listen((c) { if (c) { setState(() { _currentRatio = 16/9; _showControls(); }); widget.onAspectRatioChanged(16/9); } });
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && _isPlaying && _menuState == SettingsMenuState.none) {
        setState(() => _controlsVisible = false);
      }
    });
  }
  void _showControls() {
    _hideTimer?.cancel();
    if (mounted) setState(() => _controlsVisible = true);
    if (_isPlaying) _startHideTimer();
  }
  void _toggleControls() {
    if (_controlsVisible) { setState(() => _controlsVisible = false); _hideTimer?.cancel(); }
    else {
      _showControls();
    }
  }

  void _startActiveTimer() { if (_isBlocked) return; _activeTimer?.cancel(); _activeTimer = Timer(_protectionLimit, _triggerBlock); }
  void _pauseActiveTimer() { _activeTimer?.cancel(); }
  void _triggerBlock() { if (!mounted) return; player.pause(); setState(() => _isBlocked = true); _cooldownTimer?.cancel(); _cooldownTimer = Timer(_protectionLimit, _releaseBlock); }
  void _releaseBlock() { if (!mounted) return; setState(() => _isBlocked = false); player.play(); _startActiveTimer(); }

  Future<void> _initializeSmartStream() async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    String pref = provider.preferredQuality;
    setState(() { _isAutoMode = pref == "Auto"; _currentQualityLabel = pref; });
    await _smartSelectQuality(pref == "Auto" ? "1080p" : pref, fallback: pref == "Auto");
  }

  Future<void> _smartSelectQuality(String q, {bool fallback = false}) async {
    var qm = widget.sources.firstWhere((e) => e.quality == q, orElse: () => widget.sources.first);
    String bestUrl = "";
    try {
      bestUrl = await _findFastestLink(qm.urls);
    } catch (e) {
      if (qm.urls.isNotEmpty) bestUrl = qm.urls.first;
    }
    
    if (bestUrl.isEmpty && fallback) {
       if (q == "1080p") { await _smartSelectQuality("480p", fallback: true); }
       else if (q == "480p") { await _smartSelectQuality("240p", fallback: true); }
       else { setState(() => _isError = true); }
    } else {
      _playUrl(bestUrl, keepPosition: true);
    }
  }

  Future<String> _findFastestLink(List<String> urls) async {
    if (urls.isEmpty) return "";
    if (urls.length == 1) return urls.first;
    Map<String, int> l = {};
    await Future.wait(urls.map((url) async {
      try {
        final s = Stopwatch()..start();
        await http.head(Uri.parse(url)).timeout(const Duration(seconds: 1)); 
        s.stop();
        l[url] = s.elapsedMilliseconds;
      } catch (e) {
        l[url] = 99999; 
      }
    }));
    var e = l.entries.toList();
    e.sort((a, b) => a.value.compareTo(b.value));
    return e.first.key;
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

  @override void dispose() { player.dispose(); _activeTimer?.cancel(); _cooldownTimer?.cancel(); _hideTimer?.cancel(); super.dispose(); }

  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context); 
    return AspectRatio(aspectRatio: _currentRatio, child: LayoutBuilder(builder: (c, cs) { 
      return MouseRegion(
        onHover: (_) => _showControls(),
        cursor: _controlsVisible ? SystemMouseCursors.basic : SystemMouseCursors.none,
        child: Container(color: Colors.black, child: Stack(alignment: Alignment.center, children: [
          _isBlocked 
            ? Container(color: Colors.black, child: Center(child: Text(p.tr('wait_msg'), style: const TextStyle(color: Colors.white)))) 
            : GestureDetector(onTap: _toggleControls, child: Video(controller: controller, controls: NoVideoControls)),
          if (widget.thumbnailUrl != null) 
            AnimatedOpacity(opacity: _thumb ? 1.0 : 0.0, duration: const Duration(milliseconds: 500), child: IgnorePointer(ignoring: !_thumb, child: UniversalImage(path: widget.thumbnailUrl!, fit: BoxFit.cover, width: double.infinity, height: double.infinity))),
          if (_isError) Container(color: Colors.black87, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.wifi_off, color: Colors.red), ElevatedButton(onPressed: _retryPlayback, child: Text(p.tr('retry')))])),
          if (!_isBlocked && !_isError && !_isAd) 
            AnimatedOpacity(
              opacity: _controlsVisible ? 1.0 : 0.0, 
              duration: const Duration(milliseconds: 300),
              child: IgnorePointer(ignoring: !_controlsVisible, child: Stack(children: [
                if (!_isPlaying) Center(child: IconButton(iconSize: 64, icon: const Icon(Icons.play_circle_fill, color: Colors.white), onPressed: player.play)),
                Positioned(bottom: 0, left: 0, right: 0, child: Container(
                  decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.black87, Colors.transparent])),
                  padding: const EdgeInsets.all(16),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    StreamBuilder<Duration>(
                      stream: player.stream.position,
                      builder: (context, snapshot) {
                        final pos = snapshot.data ?? Duration.zero;
                        final dur = player.state.duration;
                        return Row(children: [
                          Text(_fmtDuration(pos), style: const TextStyle(color: Colors.white, fontSize: 12)),
                          Expanded(child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6), trackHeight: 2),
                            child: Slider(
                              value: pos.inSeconds.toDouble().clamp(0, dur.inSeconds.toDouble()),
                              min: 0,
                              max: dur.inSeconds.toDouble(),
                              activeColor: Colors.amber,
                              inactiveColor: Colors.white24,
                              onChanged: (v) => player.seek(Duration(seconds: v.toInt())),
                            ),
                          )),
                          Text(_fmtDuration(dur), style: const TextStyle(color: Colors.white, fontSize: 12)),
                        ]);
                      }
                    ),
                    Row(children: [
                      IconButton(icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white), onPressed: player.playOrPause),
                      const Spacer(),
                      IconButton(icon: Icon(Icons.settings, color: _menuState != SettingsMenuState.none ? Colors.amber : Colors.white), onPressed: () => setState(() => _menuState = _menuState == SettingsMenuState.none ? SettingsMenuState.main : SettingsMenuState.none)),
                    ])
                  ])
                )),
                if (_menuState != SettingsMenuState.none) _menu(cs, p)
              ]))
            ),
          if (_isAd) Positioned.fill(child: SmartAdContainer(adAspectRatio: _currentRatio, onClose: () => setState(() => _isAd = false), adContent: Container(color: Colors.red))),
        ]))
      );
    })); 
  }

  String _fmtDuration(Duration d) => "${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";

  Widget _menu(BoxConstraints c, AppProvider p) => Positioned(bottom: 80, right: 20, child: Container(
    width: min(250.0, c.maxWidth * 0.5), 
    decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
    child: Column(mainAxisSize: MainAxisSize.min, children: _buildMenuContent(p))
  ));

  List<Widget> _buildMenuContent(AppProvider p) {
    if (_menuState == SettingsMenuState.main) {
      return [
      ListTile(title: Text(p.tr('quality'), style: const TextStyle(color: Colors.white)), trailing: const Icon(Icons.arrow_right, color: Colors.white), onTap: () => setState(() => _menuState = SettingsMenuState.quality)),
      ListTile(title: Text(p.tr('speed'), style: const TextStyle(color: Colors.white)), trailing: const Icon(Icons.arrow_right, color: Colors.white), onTap: () => setState(() => _menuState = SettingsMenuState.speed)),
    ];
    }
    if (_menuState == SettingsMenuState.quality) {
      return [
       ListTile(leading: const Icon(Icons.arrow_back, color: Colors.amber), title: Text(p.tr('back'), style: const TextStyle(color: Colors.amber)), onTap: () => setState(() => _menuState = SettingsMenuState.main)),
       ListTile(title: const Text("Auto", style: TextStyle(color: Colors.white)), trailing: _isAutoMode ? const Icon(Icons.check, color: Colors.amber) : null, onTap: () { setState(() { _isAutoMode = true; }); _smartSelectQuality("1080p", fallback: true); }),
       ...widget.sources.map((q) => ListTile(title: Text(q.quality, style: const TextStyle(color: Colors.white)), trailing: (!_isAutoMode && _currentQualityLabel == q.quality) ? const Icon(Icons.check, color: Colors.amber) : null, onTap: () { setState(() { _isAutoMode = false; _currentQualityLabel = q.quality; }); _smartSelectQuality(q.quality); }))
    ];
    }
    if (_menuState == SettingsMenuState.speed) return [0.5, 1.0, 1.5, 2.0].map((s) => ListTile(title: Text("${s}x", style: const TextStyle(color: Colors.white)), onTap: () => player.setRate(s))).toList();
    return [];
  }
}
