import 'dart:async';
import 'dart:math';
import 'package:web/web.dart' as web; // Wasm Compatible Import
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
import 'package:my_video_project/presentation/components/ads/stubborn_ad_container.dart';

enum SettingsMenuState { none, main, speed, quality, subtitles, aiLanguages }

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
  bool _thumb = true; bool _loop = false; bool _ai = false;
  bool _showControls = true; Timer? _controlsTimer;

  bool _isIntervalAd = false; 
  Timer? _intervalTimer;
  final String _adScript = """
    <script>
      atOptions = { 'key' : 'ea534947875b8853a56110f9767a6a83', 'format' : 'iframe', 'height' : 250, 'width' : 300, 'params' : {} };
    </script>
    <script src="https://www.highperformanceformat.com/ea534947875b8853a56110f9767a6a83/invoke.js"></script>
  """;

  bool _isError = false; bool _isBuffering = false;
  bool _isFullscreen = false;
  
  bool _isBlocked = false; 
  Timer? _activeTimer; Timer? _cooldownTimer;
  final Duration _protectionLimit = const Duration(minutes: 4, seconds: 53);

  bool _optimisticPlaying = false;
  double _dragValue = -1.0;

  String _currentQualityLabel = "Auto"; 
  String _activeUrl = ""; 
  bool _isAutoMode = true; 
  double _currentRatio = 16/9;
  int _currentLinkIndex = 0;
  List<String> _currentUrlList = [];

  @override void initState() {
    super.initState();
    player = Player(configuration: const PlayerConfiguration(bufferSize: 64 * 1024 * 1024));
    controller = VideoController(player);
    
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

    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeSmartStream());
    
    Connectivity().onConnectivityChanged.listen((result) { 
      if ((_isError || _isBuffering) && !result.contains(ConnectivityResult.none)) {
        _retryPlayback();
      }
    });
    
    player.stream.error.listen((e) => _triggerFailover());
    player.stream.buffering.listen((b) => setState(() => _isBuffering = b));

    _intervalTimer = Timer.periodic(const Duration(minutes: 30), (timer) { 
      if (player.state.playing && _isFullscreen && !_isIntervalAd && !_isBlocked) {
        _triggerIntervalAd(); 
      }
    });

    player.stream.playing.listen((p) { 
      if (mounted) setState(() => _optimisticPlaying = p);
      if (p && _thumb && mounted) setState(() => _thumb = false); 
      if (p) { _startActiveTimer(); _startControlsTimer(); } else {
        _pauseActiveTimer();
      } 
    });
  }

  void _startControlsTimer() {
    _controlsTimer?.cancel();
    if(mounted) setState(() => _showControls = true);
    _controlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && player.state.playing && _menuState == SettingsMenuState.none && _dragValue == -1.0) {
        setState(() => _showControls = false);
      }
    });
  }

  void _userInteraction() { _startControlsTimer(); }

  void _startActiveTimer() {
    if (_isBlocked) return;
    _activeTimer?.cancel();
    _activeTimer = Timer(_protectionLimit, _triggerBlock);
  }
  void _pauseActiveTimer() { _activeTimer?.cancel(); }
  void _triggerBlock() {
    if (!mounted) return;
    player.pause();
    setState(() => _isBlocked = true);
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer(_protectionLimit, _releaseBlock);
  }
  void _releaseBlock() {
    if (!mounted) return;
    setState(() => _isBlocked = false);
    player.play();
    _startActiveTimer();
  }

  Future<void> _initializeSmartStream() async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    String pref = provider.preferredQuality;
    setState(() { _isAutoMode = pref == "Auto"; _currentQualityLabel = pref; });
    if (_isAutoMode) {
      await _autoSelectBestQualityAndLink();
    } else {
      await _manualSelectQuality(pref);
    }
  }

  Future<void> _autoSelectBestQualityAndLink() async {
    var q = widget.sources.firstWhere((e) => e.quality == "1080p", orElse: () => widget.sources.first);
    _currentUrlList = q.urls;
    _playUrl(await _performLinkRace(q.urls)); 
  }

  Future<void> _manualSelectQuality(String q) async {
    var qm = widget.sources.firstWhere((e) => e.quality == q, orElse: () => widget.sources.first);
    _currentUrlList = qm.urls;
    _playUrl(await _performLinkRace(qm.urls), keepPosition: true);
  }

  Future<String> _performLinkRace(List<String> urls) async {
    if (urls.isEmpty) return "";
    if (urls.length == 1) return urls.first;
    Map<String, int> l = {};
    await Future.wait(urls.map((url) async {
      try {
        final s = Stopwatch()..start();
        await http.head(Uri.parse(url)).timeout(const Duration(seconds: 2));
        s.stop();
        l[url] = s.elapsedMilliseconds;
      } catch (e) { l[url] = 99999; }
    }));
    var e = l.entries.toList()..sort((a, b) => a.value.compareTo(b.value));
    _currentLinkIndex = 0; 
    return e.isEmpty ? urls.first : e.first.key;
  }

  void _triggerFailover() {
    if (_currentLinkIndex + 1 < _currentUrlList.length) {
      _currentLinkIndex++;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(Provider.of<AppProvider>(context, listen: false).tr('link_fail'))));
      _playUrl(_currentUrlList[_currentLinkIndex], keepPosition: true);
    } else {
      setState(() => _isError = true);
    }
  }

  void _playUrl(String url, {bool keepPosition = false}) {
    if (url.isEmpty || url == _activeUrl) return;
    _activeUrl = url;
    Duration c = player.state.position;
    setState(() => _isError = false);
    player.open(Media(url, httpHeaders: {'Cache-Control': 'max-age=3600', 'Range': 'bytes=0-'}), play: true);
    if (keepPosition) Future.delayed(const Duration(milliseconds: 500), () => player.seek(c));
  }

  void _retryPlayback() { 
    setState(() { _isError = false; _isBuffering = true; });
    _playUrl(_activeUrl, keepPosition: true); 
  }
  
  // Wasm Compatible Fullscreen Logic
  void _toggleFullscreen() async { 
    if (_isFullscreen) { 
      web.document.exitFullscreen(); // Wasm Compatible
      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); 
      setState(() => _isFullscreen = false); 
    } else { 
      web.document.documentElement?.requestFullscreen(); // Wasm Compatible
      if (_currentRatio >= 1) {
        await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
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
      setState(() { _isIntervalAd = false; }); 
      player.play(); 
    } 
  }
  
  @override void dispose() { player.dispose(); _activeTimer?.cancel(); _cooldownTimer?.cancel(); _intervalTimer?.cancel(); _controlsTimer?.cancel(); super.dispose(); }

  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context); 
    return AspectRatio(aspectRatio: _currentRatio, child: LayoutBuilder(builder: (c, cs) { 
      return MouseRegion(onHover: (_) => _userInteraction(), child: GestureDetector(
        onTap: () { 
          _userInteraction(); 
          if (_menuState != SettingsMenuState.none) {
            setState(() => _menuState = SettingsMenuState.none);
          } else {
            setState(() => _showControls = !_showControls);
          } 
        }, 
        child: Container(color: Colors.black, child: Stack(alignment: Alignment.center, children: [
          _isBlocked ? Container(color: Colors.black, width: double.infinity, height: double.infinity, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.lock_clock, color: Colors.white54, size: 50), const SizedBox(height: 16), Text(p.tr('protected'), style: const TextStyle(color: Colors.white, fontSize: 18)), Text(p.tr('wait_msg'), style: const TextStyle(color: Colors.white54))])) 
          : Video(controller: controller, controls: NoVideoControls, fit: BoxFit.contain), 
          
          if (widget.thumbnailUrl != null) AnimatedOpacity(opacity: _thumb ? 1.0 : 0.0, duration: const Duration(milliseconds: 500), child: IgnorePointer(ignoring: !_thumb, child: UniversalImage(path: widget.thumbnailUrl!, fit: BoxFit.cover, width: double.infinity, height: double.infinity))), 
          
          if (!_isIntervalAd && _thumb && !player.state.playing && !_isError) Center(child: IconButton(iconSize: 64, icon: const Icon(Icons.play_circle_fill, color: Colors.white), onPressed: () => player.play())), 
          
          if (_isError) Positioned.fill(child: Container(color: Colors.black87, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.wifi_off, color: Colors.red, size: 50), Text(p.tr('connection_error'), style: const TextStyle(color: Colors.white)), const SizedBox(height: 12), ElevatedButton(onPressed: _retryPlayback, child: Text(p.tr('retry')))]))), 
          
          if (_isBuffering && !_isError && !_isBlocked) const Center(child: CircularProgressIndicator(color: Colors.amber)),

          if (!_isIntervalAd && !_isBlocked && !_isError && _showControls) _controls(), 
          
          if (!_isIntervalAd && _menuState != SettingsMenuState.none) _menu(cs, p), 
          
          if (_isIntervalAd) Positioned.fill(child: StubbornAdContainer(adAspectRatio: _currentRatio, scriptCode: _adScript, onClose: _closeAd))
        ])))); 
      })); 
  }
  
  Widget _controls() => Positioned(bottom: 0, left: 0, right: 0, child: Container(color: Colors.black54, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: SafeArea(top: false, child: Column(mainAxisSize: MainAxisSize.min, children: [
    SliderTheme(data: SliderThemeData(trackHeight: 2, thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6)), child: StreamBuilder<Duration>(stream: player.stream.position, builder: (c, s) { 
      final pos = s.data ?? Duration.zero; final dur = player.state.duration; 
      final val = _dragValue != -1.0 ? _dragValue : pos.inSeconds.toDouble();
      return Row(children: [Text(_fmt(Duration(seconds: val.toInt())), style: const TextStyle(color: Colors.white, fontSize: 12)), Expanded(child: Slider(value: val.clamp(0, dur.inSeconds.toDouble()), min: 0, max: dur.inSeconds.toDouble(), activeColor: Colors.amber, inactiveColor: Colors.white24, 
        onChangeStart: (v) => setState(() => _dragValue = v),
        onChanged: (v) => setState(() => _dragValue = v),
        onChangeEnd: (v) { player.seek(Duration(seconds: v.toInt())); setState(() => _dragValue = -1.0); }
      )), Text(_fmt(dur), style: const TextStyle(color: Colors.white, fontSize: 12))]); })),
    Row(children: [
      IconButton(icon: Icon(_optimisticPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white), onPressed: () { setState(() => _optimisticPlaying = !_optimisticPlaying); player.playOrPause(); }), 
      IconButton(icon: Icon(player.state.volume == 0 ? Icons.volume_off : Icons.volume_up, color: Colors.white), onPressed: () => player.setVolume(player.state.volume == 0 ? 100 : 0)),
      IconButton(icon: Icon(_loop ? Icons.repeat_one : Icons.repeat, color: _loop ? Colors.amber : Colors.white), onPressed: () => setState(() { _loop = !_loop; player.setPlaylistMode(_loop ? PlaylistMode.single : PlaylistMode.none); })), 
      const Spacer(), 
      IconButton(icon: Icon(_isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen, color: Colors.white), onPressed: _toggleFullscreen), 
      const SizedBox(width: 8), 
      IconButton(icon: Icon(Icons.settings, color: _menuState != SettingsMenuState.none ? Colors.amber : Colors.white), onPressed: () { _userInteraction(); setState(() => _menuState = _menuState == SettingsMenuState.none ? SettingsMenuState.main : SettingsMenuState.none); })
    ])
  ]))));

  String _fmt(Duration d) => "${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";

  Widget _menu(BoxConstraints c, AppProvider p) => Positioned(bottom: 70, right: 20, child: Material(color: Colors.transparent, child: Container(width: min(280.0, c.maxWidth * 0.45), constraints: BoxConstraints(maxHeight: c.maxHeight * 0.6), padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF1E1E1E).withValues(alpha: 0.95), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)), child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: _buildMenuContent(p))))));
  
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
      ListTile(dense: true, title: Text(p.tr('auto'), style: const TextStyle(color: Colors.white)), trailing: _isAutoMode ? const Icon(Icons.check, color: Colors.amber, size: 16) : null, onTap: () async { setState(() { _isAutoMode = true; _currentQualityLabel = "Auto"; }); await p.setPreferredQuality("Auto"); await _autoSelectBestQualityAndLink(); }), 
      ...widget.sources.map((q) => ListTile(dense: true, title: Text(q.quality, style: TextStyle(color: Colors.white)), trailing: (!_isAutoMode && _currentQualityLabel == q.quality) ? const Icon(Icons.check, color: Colors.amber, size: 16) : null, onTap: () => setState(() { _isAutoMode = false; _currentQualityLabel = q.quality; _manualSelectQuality(q.quality); })))
    ];
    }
    
    if (_menuState == SettingsMenuState.subtitles) return [ListTile(dense: true, title: Text(p.tr('back'), style: const TextStyle(color: Colors.amber)), onTap: () => setState(() => _menuState = SettingsMenuState.main)), SwitchListTile(value: _ai, onChanged: (v) => setState(() => _ai = v), title: Text(p.tr('enable_ai'), style: const TextStyle(color: Colors.white)), activeThumbColor: Colors.amber), if (_ai) ...[const Divider(color: Colors.white10), ...["Arabic", "English", "French"].map((l) => ListTile(dense: true, title: Text(l, style: TextStyle(color: "English" == l ? Colors.amber : Colors.white)), onTap: () {}))]];
    return [];
  }
}