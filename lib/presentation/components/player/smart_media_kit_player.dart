import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:js_interop';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web/web.dart' as web;
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/presentation/components/ads/ads_system.dart';
import 'package:my_video_project/core/utils/thumbnail_cache.dart';
import 'package:my_video_project/core/utils/ai_subtitle_engine.dart';
import 'package:my_video_project/core/services/email_js_service.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/core/theme/app_colors.dart';

enum SettingsMenuState { none, main, speed, quality, subtitles, subtitleLangs }

class SmartMediaKitPlayer extends StatefulWidget {
  final List<VideoQualityModel> sources;
  final String videoTitle; 
  final String videoId; 
  final String? thumbnailUrl;
  final Duration? totalDuration; 
  final Function(double ratio) onAspectRatioChanged;
  final bool isFullscreen;
  final VoidCallback onFullscreenToggle;
  
  const SmartMediaKitPlayer({super.key, required this.sources, required this.videoTitle, required this.videoId, this.totalDuration, this.thumbnailUrl, required this.onAspectRatioChanged, this.isFullscreen = false, required this.onFullscreenToggle});
  @override State<SmartMediaKitPlayer> createState() => _SmartMediaKitPlayerState();
}

class _SmartMediaKitPlayerState extends State<SmartMediaKitPlayer> {
  late final Player player; late final VideoController controller;
  SettingsMenuState _menuState = SettingsMenuState.none;
  bool _isAd = false; bool _thumb = true; bool _loop = false;
  bool _showControls = true; Timer? _controlsTimer;

  bool _isBlocked = false; bool _isError = false; bool _isIntervalAd = false; 
  bool _isCoolingDown = false; bool _isRetrying = false; 
  bool _isSwitchingSource = false; 

  // AI Subtitles
  bool _isAiSubtitlesEnabled = true;
  String _currentSubtitleLang = "Auto";
  final List<String> _availableLangs = ["Auto", "English", "Arabic", "Spanish", "French"];

  // DRM & Resume State
  Timer? _activeTimer; Timer? _cooldownTimer; Timer? _intervalAdTimer; Timer? _savePositionTimer;
  final Duration _protectionLimit = const Duration(minutes: 4, seconds: 53);
  late JSFunction _recordingDetectedListener;
  late JSFunction _recordingStoppedListener;

  String _currentQualityLabel = "Auto"; String _activeUrl = ""; 
  bool _isAutoMode = true; double _currentRatio = 16/9; 
  int _currentLinkIndex = 0; List<String> _currentUrlList = [];

  bool _isPlayingOptimistic = false; bool _isMutedOptimistic = false; double? _draggingValue; 
  
  // ✅ Task 1 & 2: Network Memory & Smart Pulse Logic
  bool _showResumePrompt = false;
  Duration _savedPosition = Duration.zero;
  Duration _lastKnownNetworkPosition = Duration.zero;
  
  bool _isActuallyAdvancing = false;
  Duration _lastPulsePosition = Duration.zero;
  Timer? _pulseTimer;

  final String _adScriptCode = """<script>atOptions = { 'key' : 'ea534947875b8853a56110f9767a6a83', 'format' : 'iframe', 'height' : 250, 'width' : 300, 'params' : {} };</script><script src="https://www.highperformanceformat.com/ea534947875b8853a56110f9767a6a83/invoke.js"></script>""";

  @override void initState() {
    super.initState();
    AiSubtitleEngine.initWorker(); 
    player = Player(configuration: const PlayerConfiguration(bufferSize: 64 * 1024 * 1024));
    controller = VideoController(player);
    
    _recordingDetectedListener = (web.Event e) { _startActiveTimer(); }.toJS;
    _recordingStoppedListener = (web.Event e) { _pauseActiveTimer(); if (_isBlocked) _releaseBlock(); }.toJS;
    web.window.addEventListener('recording_detected', _recordingDetectedListener);
    web.window.addEventListener('recording_stopped', _recordingStoppedListener);

    player.stream.videoParams.listen((params) { 
      final w = params.w; final h = params.h; 
      if (w != null && h != null && h > 0) { double nr = w / h; if ((nr - _currentRatio).abs() > 0.01) { setState(() => _currentRatio = nr); widget.onAspectRatioChanged(nr); } } 
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkSavedPosition();
      _initializeSmartStream();
      _injectNativePreloader(); 
      _startAutoSaveTimer();
      _startSmartPulseMonitor();
    });
    
    Connectivity().onConnectivityChanged.listen((result) { 
      bool hasNet = !result.contains(ConnectivityResult.none);
      if (_isError && hasNet && !_isCoolingDown && !_isRetrying) {
        _retryPlayback();
      } else if (!hasNet) { 
        if (player.state.playing) player.stop(); 
        // ✅ Task 1: Capture point-in-time on disconnect
        if (mounted) setState(() { _isError = true; _lastKnownNetworkPosition = player.state.position; }); 
      }
    });
    
    player.stream.error.listen((e) { 
      final errStr = e.toString().toLowerCase();
      if (_isSwitchingSource || errStr.contains('abort') || errStr.contains('interrupt')) return; 
      _triggerFailover(); 
    });
    
    _intervalAdTimer = Timer.periodic(const Duration(minutes: 30), (timer) { if (player.state.playing && !_isIntervalAd && !_isAd && !_isBlocked) _triggerIntervalAd(); });
    
    player.stream.playing.listen((p) { 
      if (p && _thumb && mounted) setState(() => _thumb = false);
      if (mounted) setState(() => _isPlayingOptimistic = p);
      if (p) { _isSwitchingSource = false; _startControlsTimer(); } 
    });
    
    player.stream.volume.listen((v) { if(mounted) setState(() => _isMutedOptimistic = v == 0); });
  }

  void _injectNativePreloader() {
    try {
      final videos = web.document.querySelectorAll('video');
      for (int i = 0; i < videos.length; i++) {
        final v = videos.item(i) as web.HTMLVideoElement;
        v.setAttribute('preload', 'auto');
        v.setAttribute('disableRemotePlayback', 'true');
      }
    } catch (_) { /* Ignore */ }
  }

  // ✅ Task 2: Smart Pulse Logic
  void _startSmartPulseMonitor() {
    _pulseTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (!mounted) return;
      final currentPos = player.state.position;
      final advancing = currentPos.inMilliseconds > _lastPulsePosition.inMilliseconds;
      _lastPulsePosition = currentPos;
      if (_isActuallyAdvancing != advancing) setState(() => _isActuallyAdvancing = advancing);
    });
  }

  Future<void> _checkSavedPosition() async {
    if (widget.totalDuration == null || widget.totalDuration!.inSeconds == 0) return;
    final prefs = await SharedPreferences.getInstance();
    int? savedSeconds = prefs.getInt('pos_${widget.videoId}');
    if (savedSeconds != null && savedSeconds > 5) {
      if (mounted) setState(() { _savedPosition = Duration(seconds: savedSeconds); _showResumePrompt = true; });
    }
  }

  void _startAutoSaveTimer() {
    if (widget.totalDuration == null || widget.totalDuration!.inSeconds == 0) return;
    _savePositionTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (player.state.playing && player.state.position.inSeconds > 5) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('pos_${widget.videoId}', player.state.position.inSeconds);
      }
    });
  }

  // ✅ Task 3: Zero-Latency Awaited Seek Resume
  Future<void> _resumeFromPrompt() async {
    if (_savedPosition.inSeconds > 0) {
      setState(() => _showResumePrompt = false); // Optimistic UI kill
      await player.seek(_savedPosition);        // Respect Keyframes
      player.play();
    } else {
      setState(() => _showResumePrompt = false);
    }
  }

  @override void didUpdateWidget(SmartMediaKitPlayer oldWidget) { 
    super.didUpdateWidget(oldWidget); 
    if (widget.sources != oldWidget.sources) _resetAndPlayNewSource(); 
  }

  void _resetAndPlayNewSource() async { 
    _isSwitchingSource = true; 
    player.stop(); 
    setState(() { _isError = false; _thumb = true; _isCoolingDown = false; _isPlayingOptimistic = true; _showResumePrompt = false; }); 
    await _initializeSmartStream(); 
  }

  void _startControlsTimer() { _controlsTimer?.cancel(); if(mounted) setState(() => _showControls = true); _controlsTimer = Timer(const Duration(seconds: 3), () { if (mounted && player.state.playing && _menuState == SettingsMenuState.none) setState(() => _showControls = false); }); }
  void _handleGlobalTap() { if (_showControls && _menuState == SettingsMenuState.none) { setState(() => _showControls = false); _controlsTimer?.cancel(); } else { setState(() { _showControls = true; _menuState = SettingsMenuState.none; }); _startControlsTimer(); } }

  void _startActiveTimer() { if (_isBlocked) return; _activeTimer?.cancel(); _activeTimer = Timer(_protectionLimit, _triggerBlock); }
  void _pauseActiveTimer() { _activeTimer?.cancel(); }
  void _triggerBlock() { if (!mounted) return; player.pause(); setState(() => _isBlocked = true); _cooldownTimer?.cancel(); _cooldownTimer = Timer(_protectionLimit, _releaseBlock); }
  void _releaseBlock() { if (!mounted) return; setState(() => _isBlocked = false); player.play(); _startActiveTimer(); }

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

  Future<void> _autoSelectBestQualityAndLink() async { var q = widget.sources.firstWhere((e) => e.quality == "1080p", orElse: () => widget.sources.first); _currentUrlList = q.urls; _playUrl(await _performLinkRace(q.urls)); }
  Future<void> _manualSelectQuality(String q) async { var qm = widget.sources.firstWhere((e) => e.quality == q, orElse: () => widget.sources.first); _currentUrlList = qm.urls; _playUrl(await _performLinkRace(qm.urls), keepPosition: true); }
  Future<String> _performLinkRace(List<String> urls) async { if (urls.isEmpty) return ""; if (urls.length == 1) return urls.first; Map<String, int> l = {}; await Future.wait(urls.map((url) async { try { final s = Stopwatch()..start(); await http.head(Uri.parse(url)).timeout(const Duration(seconds: 2)); s.stop(); l[url] = s.elapsedMilliseconds; } catch (e) { l[url] = 99999; } })); var e = l.entries.toList(); e.sort((a, b) => a.value.compareTo(b.value)); _currentLinkIndex = 0; return e.isEmpty ? urls.first : e.first.key; }

  void _triggerFailover() {
    if (_isCoolingDown) return; 
    _lastKnownNetworkPosition = player.state.position;
    EmailJsService.reportBrokenLink(videoTitle: widget.videoTitle, brokenUrl: _activeUrl, quality: _currentQualityLabel);
    if (_currentLinkIndex + 1 < _currentUrlList.length) { _currentLinkIndex++; ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(Provider.of<AppProvider>(context, listen: false).tr('link_fail')))); _playUrl(_currentUrlList[_currentLinkIndex], keepPosition: true); } 
    else { player.stop(); setState(() { _isError = true; _isCoolingDown = true; }); Future.delayed(const Duration(seconds: 5), () { if (mounted) setState(() => _isCoolingDown = false); }); }
  }

  void _playUrl(String url, {bool keepPosition = false}) { 
    if (url.isEmpty || url == _activeUrl) return; 
    _activeUrl = url; 
    Duration c = _lastKnownNetworkPosition.inSeconds > 0 ? _lastKnownNetworkPosition : player.state.position; 
    setState(() => _isError = false); 
    
    player.open(Media(url, httpHeaders: {'Cache-Control': 'max-age=3600', 'Range': 'bytes=0-'}), play: true); 
    
    if (keepPosition || _lastKnownNetworkPosition.inSeconds > 0) {
      Future.delayed(const Duration(milliseconds: 500), () { player.seek(c); _lastKnownNetworkPosition = Duration.zero; });
    }
    _handleAiSubtitles(); 
  }

  void _handleAiSubtitles() {
    if (_isAiSubtitlesEnabled && _currentSubtitleLang != "Off") {
      AiSubtitleEngine.processVideo(_currentSubtitleLang);
    } else {
      AiSubtitleEngine.stop();
    }
  }

  // ✅ Task 1: Network Retry Position Injection
  void _retryPlayback() { 
    if (_isCoolingDown || _isRetrying) return; 
    setState(() { _isError = false; _isCoolingDown = true; _isRetrying = true; });
    player.open(Media(_activeUrl)); 
    Future.delayed(const Duration(milliseconds: 500), () {
        if (_lastKnownNetworkPosition.inSeconds > 0) { player.seek(_lastKnownNetworkPosition); _lastKnownNetworkPosition = Duration.zero; }
    });
    Future.delayed(const Duration(seconds: 3), () { if(mounted) setState(() { _isCoolingDown = false; _isRetrying = false; }); });
  }
  
  void _toggleFullscreenLogic() {
    try {
      if (!widget.isFullscreen) {
        web.document.documentElement?.requestFullscreen();
        if (_currentRatio > 1.0) {
          web.window.screen.orientation.lock('landscape');
        } else {
          web.window.screen.orientation.lock('portrait');
        }
      } else {
        web.document.exitFullscreen();
        web.window.screen.orientation.unlock();
      }
    } catch (e) { /* Ignore unsupported API errors silently */ }
    widget.onFullscreenToggle();
  }

  void _triggerIntervalAd() { if (!mounted) return; player.pause(); setState(() => _isIntervalAd = true); }
  void _closeAd() { if (mounted) { setState(() { _isAd = false; _isIntervalAd = false; }); player.play(); } }
  
  @override void dispose() { 
    web.window.removeEventListener('recording_detected', _recordingDetectedListener);
    web.window.removeEventListener('recording_stopped', _recordingStoppedListener);
    _savePositionTimer?.cancel();
    _pulseTimer?.cancel();
    AiSubtitleEngine.stop(); player.dispose(); _activeTimer?.cancel(); _cooldownTimer?.cancel(); _intervalAdTimer?.cancel(); _controlsTimer?.cancel(); super.dispose(); 
  }

  @override Widget build(BuildContext context) { final p = Provider.of<AppProvider>(context); return LayoutBuilder(builder: (c, cs) { return MouseRegion(onHover: (_) => _startControlsTimer(), child: Stack(alignment: Alignment.center, children: [
    _isBlocked ? Container(color: Colors.black, width: double.infinity, height: double.infinity, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.lock_clock, color: Colors.white54, size: 50), const SizedBox(height: 16), Text(p.tr('protected'), style: const TextStyle(color: Colors.white, fontSize: 18)), Text(p.tr('wait_msg'), style: const TextStyle(color: Colors.white54))])) 
               : Video(controller: controller, controls: NoVideoControls, fit: BoxFit.contain), 
    
    // Absolute Adaptive Subtitle Overlay
    Positioned.fill(
      child: AspectRatio(
        aspectRatio: _currentRatio,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: cs.maxHeight * 0.12),
            child: ValueListenableBuilder<String>(
              valueListenable: AiSubtitleEngine.currentSubtitle,
              builder: (context, text, child) {
                if (text.isEmpty || !_isAiSubtitlesEnabled || _currentSubtitleLang == "Off") return const SizedBox.shrink();
                double fontSize = (cs.maxWidth * 0.035).clamp(14.0, 32.0); 
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(8)),
                  child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.bold, shadows: const [Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 2)])),
                );
              }
            ),
          ),
        ),
      ),
    ),

    if (_thumb) FutureBuilder<Uint8List?>(
      future: ThumbnailCache.getThumbnail(widget.thumbnailUrl ?? widget.sources.first.urls.first),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return Container(color: Colors.black, child: const Center(child: CircularProgressIndicator(color: Colors.amber)));
        if (snapshot.hasData && snapshot.data != null) return AnimatedOpacity(opacity: _thumb ? 1.0 : 0.0, duration: const Duration(milliseconds: 500), child: Image.memory(snapshot.data!, fit: BoxFit.cover, width: double.infinity, height: double.infinity));
        return Container(color: Colors.black);
      }
    ),
    
    Positioned.fill(child: GestureDetector(behavior: HitTestBehavior.translucent, onTap: _handleGlobalTap, child: Container(color: Colors.transparent))),
    if (!_isAd && !_isIntervalAd && _thumb && !player.state.playing && !_isError) Center(child: IconButton(iconSize: 64, icon: const Icon(Icons.play_circle_fill, color: Colors.white), onPressed: () => player.play())), 
  
    if (_isError || _isCoolingDown) Positioned.fill(child: Container(color: Colors.black87, child: Center(child: FittedBox(fit: BoxFit.scaleDown, child: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.wifi_off, color: Colors.red, size: 50), const SizedBox(height: 16), Text(_isCoolingDown ? p.tr('cooling_down') : p.tr('connection_error'), style: const TextStyle(color: Colors.white, fontSize: 16)), const SizedBox(height: 16), if (!_isCoolingDown) ElevatedButton.icon(icon: const Icon(Icons.refresh), label: Text(p.tr('retry')), style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black), onPressed: _retryPlayback) else const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))]))))), 
    
    // ✅ Task 2: Smart Pulse Loader (Only show if buffering AND actually not advancing)
    if (player.state.buffering && !_isActuallyAdvancing && !_isError) const Center(child: CircularProgressIndicator(color: Colors.amber)),
    
    ValueListenableBuilder<bool>(
      valueListenable: AiSubtitleEngine.isModelLoading,
      builder: (context, isLoading, child) {
        if (!isLoading || !_isAiSubtitlesEnabled) return const SizedBox.shrink();
        return Positioned(top: 16, right: 16, child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)), child: Row(children: [const SizedBox(width: 12, height: 12, child: CircularProgressIndicator(color: Colors.amber, strokeWidth: 2)), const SizedBox(width: 8), Text(p.tr('ai_loading'), style: const TextStyle(color: Colors.amber, fontSize: 10))])));
      }
    ),

    if (!_isAd && !_isIntervalAd && !_isBlocked && !_isError && _showControls) _buildControlsUI(p), 
    if (!_isAd && !_isIntervalAd && _menuState != SettingsMenuState.none) _buildMenuUI(cs.biggest, p), 
  
    if (_isAd || _isIntervalAd) Positioned.fill(child: WebAdBanner(adScript: _adScriptCode, onClose: _closeAd)),
    
    Positioned(
      top: 16, left: 16, 
      child: SafeArea(
        child: SizedBox(
          width: (cs.maxWidth * 0.06).clamp(30.0, 70.0), 
          child: const UniversalImage(path: 'https://iili.io/q2Ty8N4.webp', fit: BoxFit.contain)
        )
      )
    ),

    if (_showResumePrompt)
      Positioned(
        bottom: 24, left: 16, right: 16,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(color: const Color(0xFF323232), borderRadius: BorderRadius.circular(8), boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(0, 4))]),
            child: Directionality(
              textDirection: TextDirection.rtl, 
              child: Row(
                children: [
                  Expanded(child: Text(p.tr('resume_msg'), style: const TextStyle(color: Colors.white, fontSize: 14))),
                  TextButton(onPressed: _resumeFromPrompt, child: Text(p.tr('resume_btn'), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold))),
                  IconButton(icon: const Icon(Icons.close, color: Colors.white70, size: 20), padding: EdgeInsets.zero, constraints: const BoxConstraints(), onPressed: () => setState(() => _showResumePrompt = false)),
                ],
              ),
            ),
          ),
        )
      )

  ])); }); }
  
  Widget _buildControlsUI(AppProvider p) => Positioned(bottom: 0, left: 0, right: 0, child: Container(color: Colors.black54, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: SafeArea(top: false, child: Column(mainAxisSize: MainAxisSize.min, children: [
    SliderTheme(data: const SliderThemeData(trackHeight: 2, thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6)), child: StreamBuilder<Duration>(stream: player.stream.position, builder: (c, s) { final pos = s.data ?? Duration.zero; final dur = player.state.duration; final currentVal = _draggingValue ?? pos.inSeconds.toDouble(); return Row(children: [Text(_fmt(Duration(seconds: currentVal.toInt())), style: const TextStyle(color: Colors.white, fontSize: 12)), Expanded(child: Slider(value: currentVal.clamp(0, dur.inSeconds.toDouble()), min: 0, max: dur.inSeconds.toDouble() > 0 ? dur.inSeconds.toDouble() : 1, activeColor: Colors.amber, inactiveColor: Colors.white24, onChangeStart: (v) => setState(() => _draggingValue = v), onChanged: (v) => setState(() => _draggingValue = v), onChangeEnd: (v) { player.seek(Duration(seconds: v.toInt())); setState(() => _draggingValue = null); })), Text(_fmt(dur), style: const TextStyle(color: Colors.white, fontSize: 12))]); })),
    Row(children: [
      IconButton(icon: Icon(_isPlayingOptimistic ? Icons.pause : Icons.play_arrow, color: Colors.white), onPressed: () { setState(() => _isPlayingOptimistic = !_isPlayingOptimistic); player.playOrPause(); }), 
      IconButton(icon: Icon(_isMutedOptimistic ? Icons.volume_off : Icons.volume_up, color: Colors.white), onPressed: () { setState(() => _isMutedOptimistic = !_isMutedOptimistic); player.setVolume(player.state.volume == 0 ? 100 : 0); }),
      IconButton(icon: Icon(_loop ? Icons.repeat_one : Icons.repeat, color: _loop ? Colors.amber : Colors.white), onPressed: () => setState(() { _loop = !_loop; player.setPlaylistMode(_loop ? PlaylistMode.single : PlaylistMode.none); })), 
      const Spacer(), 
      IconButton(icon: Icon(widget.isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen, color: Colors.white), onPressed: _toggleFullscreenLogic), 
      const SizedBox(width: 8), 
      IconButton(icon: Icon(Icons.settings, color: _menuState != SettingsMenuState.none ? Colors.amber : Colors.white), onPressed: () { _startControlsTimer(); setState(() => _menuState = _menuState == SettingsMenuState.none ? SettingsMenuState.main : SettingsMenuState.none); })
    ])
  ]))));

  String _fmt(Duration d) => "${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}";

  Widget _buildMenuUI(Size size, AppProvider p) => Positioned(bottom: 70, right: 20, child: Material(color: Colors.transparent, child: Container(width: min(280.0, size.width * 0.45), constraints: BoxConstraints(maxHeight: size.height * 0.6), padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF1E1E1E).withValues(alpha: 0.95), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)), child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: _buildMenuContent(p))))));
  
  List<Widget> _buildMenuContent(AppProvider p) {
    if (_menuState == SettingsMenuState.main) {
      return [
      ListTile(dense: true, title: Text(p.tr('speed'), style: const TextStyle(color: Colors.white)), onTap: () => setState(() => _menuState = SettingsMenuState.speed), trailing: const Icon(Icons.chevron_right, color: Colors.white)), 
      const Divider(color: Colors.white10), 
      ListTile(dense: true, title: Text(p.tr('quality'), style: const TextStyle(color: Colors.white)), subtitle: Text(_currentQualityLabel, style: const TextStyle(color: Colors.amber, fontSize: 10)), onTap: () => setState(() => _menuState = SettingsMenuState.quality), trailing: const Icon(Icons.chevron_right, color: Colors.white)),
      const Divider(color: Colors.white10), 
      ListTile(dense: true, title: Text(p.tr('subtitles'), style: const TextStyle(color: Colors.white)), subtitle: Text(_currentSubtitleLang, style: const TextStyle(color: Colors.amber, fontSize: 10)), onTap: () => setState(() => _menuState = SettingsMenuState.subtitles), trailing: const Icon(Icons.chevron_right, color: Colors.white)),
    ];
    }
    if (_menuState == SettingsMenuState.speed) return [ListTile(dense: true, title: Text(p.tr('back'), style: const TextStyle(color: Colors.amber)), onTap: () => setState(() => _menuState = SettingsMenuState.main)), ...[0.5, 1.0, 1.5, 2.0].map((s) => ListTile(dense: true, title: Text("${s}x", style: TextStyle(color: player.state.rate == s ? Colors.amber : Colors.white)), onTap: () => setState(() { player.setRate(s); })))];
    if (_menuState == SettingsMenuState.quality) {
      return [
      ListTile(dense: true, title: Text(p.tr('back'), style: const TextStyle(color: Colors.amber)), onTap: () => setState(() => _menuState = SettingsMenuState.main)), 
      ListTile(dense: true, title: Text(p.tr('auto'), style: const TextStyle(color: Colors.white)), trailing: _isAutoMode ? const Icon(Icons.check, color: Colors.amber, size: 16) : null, onTap: () async { setState(() { _isAutoMode = true; _currentQualityLabel = "Auto"; }); await p.setPreferredQuality("Auto"); await _autoSelectBestQualityAndLink(); }), 
      ...widget.sources.map((q) => ListTile(dense: true, title: Text(q.quality, style: const TextStyle(color: Colors.white)), trailing: (!_isAutoMode && _currentQualityLabel == q.quality) ? const Icon(Icons.check, color: Colors.amber, size: 16) : null, onTap: () => setState(() { _isAutoMode = false; _currentQualityLabel = q.quality; _manualSelectQuality(q.quality); })))
    ];
    }
    if (_menuState == SettingsMenuState.subtitles) {
      return [
      ListTile(dense: true, title: Text(p.tr('back'), style: const TextStyle(color: Colors.amber)), onTap: () => setState(() => _menuState = SettingsMenuState.main)), 
      SwitchListTile(title: Text(p.tr('ai_transition'), style: const TextStyle(color: Colors.white, fontSize: 14)), activeThumbColor: Colors.amber, value: _isAiSubtitlesEnabled, onChanged: (v) { setState(() { _isAiSubtitlesEnabled = v; _handleAiSubtitles(); }); }),
      const Divider(color: Colors.white10),
      ListTile(dense: true, title: Text(p.tr('disable'), style: const TextStyle(color: Colors.white)), trailing: _currentSubtitleLang == "Off" ? const Icon(Icons.check, color: Colors.amber, size: 16) : null, onTap: () { setState(() { _currentSubtitleLang = "Off"; _handleAiSubtitles(); }); }),
      ..._availableLangs.map((l) => ListTile(dense: true, title: Text(l == "Auto" ? p.tr('auto') : p.tr(l.toLowerCase()), style: TextStyle(color: Colors.white.withValues(alpha: _isAiSubtitlesEnabled ? 1.0 : 0.4))), trailing: _currentSubtitleLang == l ? const Icon(Icons.check, color: Colors.amber, size: 16) : null, onTap: () { if (_isAiSubtitlesEnabled) { setState(() { _currentSubtitleLang = l; _handleAiSubtitles(); }); } }))
    ];
    }
    return [];
  }
}
