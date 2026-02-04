import 'dart:io';
import 'dart:convert'; // For UTF-8 encoding

void main() async {
  print('💎 STARTING THE DIAMOND BUILD GENERATION (TASKS 1-24 COMPLETE)...');
  print('🛡️  Injecting Cyclic Anti-Recording Logic (4:53 Active / 4:53 Blocked)...');
  print('📐 Applying Dynamic Grid Mathematics (No Text Overlap)...');
  print('🔙 Fixing Navigation Back Button Logic...');
  print('🎨 Embedding Cairo Font & UTF-8 Encoding...');
  print('🚀 Writing Project Files...');

  final Map<String, String> files = {
    // =========================================================================
    // 1. Pubspec (Added google_fonts)
    // =========================================================================
    'pubspec.yaml': r'''
name: my_video_project
description: A clean, high-performance responsive video app.
publish_to: 'none'
version: 1.0.0+1
environment:
  sdk: '>=3.2.0 <4.0.0'
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  cupertino_icons: ^1.0.6
  google_fonts: ^6.1.0
  provider: ^6.1.1
  cached_network_image: ^3.3.1
  http: ^1.2.0
  connectivity_plus: ^6.0.3
  url_launcher: ^6.2.5
  shared_preferences: ^2.2.2
  media_kit: ^1.1.10
  media_kit_video: ^1.2.4

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/ads/
''',

    // =========================================================================
    // 2. Theme Files (Critical Fix)
    // =========================================================================
    'lib/core/theme/app_colors.dart': r'''
import 'package:flutter/material.dart';
class AppColors { 
  static const Color primary = Colors.amber; 
  static const Color background = Colors.black; 
  static const Color surface = Color(0xFF151515); 
  static const Color textPrimary = Colors.white; 
  static const Color success = Colors.greenAccent; 
}
''',

    'lib/core/theme/app_styles.dart': r'''
import 'package:flutter/material.dart';
import 'app_colors.dart';
class AppStyles { 
  static const TextStyle headlineLarge = TextStyle(color: AppColors.textPrimary, fontSize: 26, fontWeight: FontWeight.bold, height: 1.2); 
  static const TextStyle headlineMedium = TextStyle(color: AppColors.textPrimary, fontSize: 20, fontWeight: FontWeight.bold); 
  static const TextStyle tagText = TextStyle(color: AppColors.textPrimary, fontSize: 11, fontWeight: FontWeight.w600); 
}
''',

    // =========================================================================
    // 3. Logic Layer (Navigation State Added)
    // =========================================================================
    'lib/core/logic/app_strings.dart': r'''
class AppStrings {
  static const Map<String, Map<String, String>> _values = {
    'en': {
      'home': 'Home', 'search': 'Search', 'list': 'My List', 'settings': 'Settings',
      'watch': 'Watch', 'notifications': 'Notifications', 'trending': 'Trending',
      'new_releases': 'New Releases', 'view_all': 'View All', 'show_more': 'Show More',
      'show_less': 'Show Less', 'autoplay': 'Autoplay', 'visit': 'Visit',
      'clear_cache': 'Clear Cache', 'about_app': 'About App', 'language': 'Language',
      'auto': 'System Default', 'en': 'English', 'ar': 'العربية',
      'content_note': 'Content Note', 'content_desc': 'This content is provided for educational purposes. Viewer discretion is advised.',
      'close': 'Close', 'cache_cleared': 'Cache cleared successfully', 'protected': 'Protected',
      'connection_error': 'Connection Lost', 'retry': 'Retry', 'episodes': 'Episodes',
      'overview': 'Overview', 'recommendations': 'Recommendations',
      'speed': 'Speed', 'quality': 'Quality', 'subtitles': 'AI Subtitles', 'enable_ai': 'Enable AI', 'back': 'Back',
      'wait_msg': 'Recording protection active. Please wait...'
    },
    'ar': {
      'home': 'الرئيسية', 'search': 'البحث', 'list': 'قائمتي', 'settings': 'الإعدادات',
      'watch': 'مشاهدة', 'notifications': 'الإشعارات', 'trending': 'الأكثر رواجاً',
      'new_releases': 'الإصدارات الجديدة', 'view_all': 'عرض الكل', 'show_more': 'عرض المزيد',
      'show_less': 'عرض أقل', 'autoplay': 'تشغيل تلقائي', 'visit': 'زيارة',
      'clear_cache': 'مسح الذاكرة المؤقتة', 'about_app': 'حول التطبيق', 'language': 'اللغة',
      'auto': 'تلقائي (النظام)', 'en': 'English', 'ar': 'العربية',
      'content_note': 'ملاحظة المحتوى', 'content_desc': 'هذا المحتوى مقدم لأغراض تعليمية. يرجى توخي الحذر عند المشاهدة.',
      'close': 'إغلاق', 'cache_cleared': 'تم مسح الذاكرة بنجاح', 'protected': 'محتوى محمي',
      'connection_error': 'انقطع الاتصال', 'retry': 'إعادة المحاولة', 'episodes': 'الحلقات',
      'overview': 'نبذة', 'recommendations': 'توصيات',
      'speed': 'السرعة', 'quality': 'الجودة', 'subtitles': 'ترجمة الذكاء الاصطناعي', 'enable_ai': 'تفعيل AI', 'back': 'رجوع',
      'wait_msg': 'حماية التسجيل نشطة. يرجى الانتظار...'
    }
  };
  static String get(String code, String key) => _values[code]?[key] ?? key;
}
''',

    'lib/core/logic/app_provider.dart': r'''
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_strings.dart';

class AppNotification {
  final String title; final String body; final String time; 
  final String? targetId; final String? payload; final String? imageUrl;
  AppNotification({required this.title, required this.body, required this.time, this.targetId, this.payload, this.imageUrl});
}

class AppProvider extends ChangeNotifier {
  // Navigation State (Task 21)
  int _navIndex = 0;
  int get navIndex => _navIndex;

  bool _notificationsEnabled = true; 
  bool _isAutoplayEnabled = true; 
  String _preferredQuality = "Auto"; 
  String _languageCode = "auto"; 

  List<AppNotification> _notifications = [];
  bool get notificationsEnabled => _notificationsEnabled;
  bool get isAutoplayEnabled => _isAutoplayEnabled;
  String get preferredQuality => _preferredQuality;
  String get currentLanguageCode => _languageCode;
  
  Locale get locale {
    if (_languageCode == 'auto') {
      final systemLoc = PlatformDispatcher.instance.locale.languageCode;
      return (systemLoc == 'ar') ? const Locale('ar') : const Locale('en');
    }
    return Locale(_languageCode);
  }

  String tr(String key) => AppStrings.get(locale.languageCode, key);
  List<AppNotification> get notifications => _notificationsEnabled ? _notifications : [];

  AppProvider() { _loadPrefs(); }

  void setNavIndex(int index) {
    _navIndex = index;
    notifyListeners();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
    _isAutoplayEnabled = prefs.getBool('autoplay_enabled') ?? true;
    _preferredQuality = prefs.getString('pref_quality') ?? "Auto";
    _languageCode = prefs.getString('app_lang') ?? "auto";
    notifyListeners();
  }

  Future<void> setLanguage(String code) async {
    _languageCode = code;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('app_lang', code);
    notifyListeners();
  }

  Future<void> toggleNotifications(bool value) async {
    _notificationsEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', value);
    notifyListeners();
  }
  Future<void> toggleAutoplay(bool value) async {
    _isAutoplayEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('autoplay_enabled', value);
    notifyListeners();
  }
  Future<void> setPreferredQuality(String value) async {
    _preferredQuality = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pref_quality', value);
    notifyListeners();
  }
  Future<void> clearCache() async { await Future.delayed(const Duration(seconds: 2)); PaintingBinding.instance.imageCache.clear(); notifyListeners(); }
}
''',

    // =========================================================================
    // 4. Data Layer
    // =========================================================================
    'lib/data/models/movie_models.dart': r'''
class VideoQualityModel {
  final String quality; final List<String> urls; 
  VideoQualityModel({required this.quality, required this.urls});
}
class EpisodeModel {
  final String id; final String title; final String? thumbnailUrl; final String duration;
  final int seasonNumber; final int episodeNumber;
  final List<VideoQualityModel> sources;
  EpisodeModel({required this.id, required this.title, this.thumbnailUrl, required this.duration, required this.seasonNumber, required this.episodeNumber, required this.sources});
}
class SeasonModel { final String id; final String title; final List<EpisodeModel> episodes; SeasonModel({required this.id, required this.title, required this.episodes}); }
class MovieModel { final int id; final String title; final String overview; final String posterPath; final List<SeasonModel> seasons; const MovieModel({required this.id, required this.title, required this.overview, required this.posterPath, this.seasons = const []}); }
class MovieSnippet { final String id; final String imageUrl; final String title; MovieSnippet({required this.id, required this.imageUrl, required this.title}); }
''',

    'lib/data/mock_data.dart': r'''
import 'package:my_video_project/data/models/movie_models.dart';

class MockData {
  static const String _vid = "https://user-images.githubusercontent.com/28053651/202696586-48e7996a-7485-414f-8484-a5416297ea42.mp4";
  static const String _img = "https://iili.io/fZAinLv.webp";
  
  static final List<MovieModel> allMovies = [
    MovieModel(
      id: 1, 
      title: "Flutter Mastery: The Complete Guide", 
      overview: "Learn how to build high-performance applications with Flutter. This comprehensive series covers everything from basic widgets to advanced state management and architectural patterns. Perfect for beginners and pros alike.", 
      posterPath: _img, 
      seasons: [
        SeasonModel(id: "s1", title: "Season 1", episodes: List.generate(5, (i) => EpisodeModel(id: "s1e$i", title: "Setup & Basics ${i+1}", duration: "24:00", seasonNumber: 1, episodeNumber: i+1, sources: [VideoQualityModel(quality: "1080p", urls: [_vid])])))
      ]
    ),
    MovieModel(
      id: 2, 
      title: "Dart Deep Dive (4:3 Aspect Test)", 
      overview: "Explore the depths of the Dart programming language. This content is designed to test dynamic aspect ratio adaptation.", 
      posterPath: _img, 
      seasons: [
        SeasonModel(id: "s1", title: "Season 1", episodes: List.generate(3, (i) => EpisodeModel(id: "d1e$i", title: "Core Concepts ${i+1}", duration: "15:00", seasonNumber: 1, episodeNumber: i+1, sources: [VideoQualityModel(quality: "720p", urls: [_vid])])))
      ]
    ),
    ...List.generate(10, (i) => MovieModel(id: 10+i, title: "Movie ${i+1}", overview: "Overview for movie $i. This is a long description to test the expandable text feature which should show a button only if the text is long enough.", posterPath: _img, seasons: [])),
  ];
}
''',

    // =========================================================================
    // 5. Components & UI
    // =========================================================================
    'lib/core/components/universal_image.dart': r'''
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_video_project/core/theme/app_colors.dart';

class UniversalImage extends StatelessWidget {
  final String path; final BoxFit fit; final double? width; final double? height; final Widget? errorPlaceholder;
  const UniversalImage({super.key, required this.path, this.fit = BoxFit.cover, this.width, this.height, this.errorPlaceholder});
  @override Widget build(BuildContext context) { 
    return AspectRatio(aspectRatio: 2 / 3, child: Container(color: const Color(0xFF1A1A1A), child: _buildImage())); 
  }
  Widget _buildImage() {
    if (path.startsWith('http')) return CachedNetworkImage(imageUrl: path, fit: fit, width: width, height: height, placeholder: (c, u) => const Center(child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2)), errorWidget: (c, u, e) => _buildErrorWidget());
    else return Image.asset(path, fit: fit, width: width, height: height, errorBuilder: (c, e, s) => _buildErrorWidget());
  }
  Widget _buildErrorWidget() { return LayoutBuilder(builder: (context, constraints) => Center(child: Icon(Icons.broken_image_rounded, color: Colors.white12, size: constraints.maxWidth * 0.4))); }
}
''',

    'lib/core/components/expandable_text.dart': r'''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';

class ExpandableText extends StatefulWidget { 
  final String text; final int maxLines; 
  const ExpandableText({super.key, required this.text, this.maxLines = 3}); 
  @override State<ExpandableText> createState() => _ExpandableTextState(); 
}
class _ExpandableTextState extends State<ExpandableText> { 
  bool _expanded = false; 
  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context);
    return LayoutBuilder(builder: (context, constraints) {
      final span = TextSpan(text: widget.text, style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5));
      final tp = TextPainter(text: span, maxLines: widget.maxLines, textDirection: TextDirection.ltr);
      tp.layout(maxWidth: constraints.maxWidth);
      final bool isOverflowing = tp.didExceedMaxLines;
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.text, maxLines: _expanded ? null : widget.maxLines, overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5)), 
        if (isOverflowing) ...[const SizedBox(height: 4), GestureDetector(onTap: () => setState(() => _expanded = !_expanded), child: Text(_expanded ? p.tr('show_less') : p.tr('show_more'), style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 12)))]
      ]);
    });
  } 
}
''',

    'lib/presentation/components/buttons/action_icon_button.dart': r'''
import 'package:flutter/material.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
class ActionIconButton extends StatelessWidget { final IconData icon; final String label; final VoidCallback onTap; final bool isVertical; final bool isActive; const ActionIconButton({super.key, required this.icon, required this.label, required this.onTap, this.isVertical = true, this.isActive = false}); @override Widget build(BuildContext context) { final c = isActive ? AppColors.primary : AppColors.textPrimary; return InkWell(onTap: onTap, borderRadius: BorderRadius.circular(8), child: Padding(padding: const EdgeInsets.all(8.0), child: isVertical ? Column(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: c, size: 24), const SizedBox(height: 4), Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10))]) : Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: c, size: 20), const SizedBox(width: 8), Text(label, style: TextStyle(color: c, fontSize: 14))]))); } }
''',

    'lib/presentation/components/ads/ads_system.dart': r'''
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AdaptiveCloseAdButton extends StatelessWidget { final VoidCallback onPressed; const AdaptiveCloseAdButton({super.key, required this.onPressed}); @override Widget build(BuildContext context) { return InkWell(onTap: onPressed, borderRadius: BorderRadius.circular(20), child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.7), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white54)), child: Row(mainAxisSize: MainAxisSize.min, children: const [Text("Close AD", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)), SizedBox(width: 4), Icon(Icons.close, color: Colors.white, size: 14)]))); } }
class FullscreenAdViewer extends StatelessWidget { final Widget adContent; final String? externalAdUrl; const FullscreenAdViewer({super.key, required this.adContent, this.externalAdUrl}); Future<void> _open() async { if (externalAdUrl != null && await canLaunchUrl(Uri.parse(externalAdUrl!))) await launchUrl(Uri.parse(externalAdUrl!), mode: LaunchMode.externalApplication); } @override Widget build(BuildContext context) { return Scaffold(backgroundColor: Colors.black, body: Stack(alignment: Alignment.center, children: [InteractiveViewer(minScale: 0.5, maxScale: 4.0, child: Center(child: adContent)), Positioned(top: 20, left: 20, child: SafeArea(child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.7), borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.white24)), child: Row(children: [InkWell(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: Colors.white)), if (externalAdUrl != null) ...[Container(height: 18, width: 1, color: Colors.white38, margin: const EdgeInsets.symmetric(horizontal: 12)), InkWell(onTap: _open, child: const Icon(Icons.open_in_browser_rounded, color: Colors.amber))]]))))])); } }
class ReliableAdLoader extends StatefulWidget { final String adUrl; final Widget Function(BuildContext, String) adBuilder; const ReliableAdLoader({super.key, required this.adUrl, required this.adBuilder}); @override State<ReliableAdLoader> createState() => ReliableAdLoaderState(); }
class ReliableAdLoaderState extends State<ReliableAdLoader> { bool _err = false; Key _k = UniqueKey(); StreamSubscription? _sub; @override void initState() { super.initState(); _sub = Connectivity().onConnectivityChanged.listen((l) { if (_err && !l.contains(ConnectivityResult.none)) _retry(); }); } void _retry() { if (mounted) setState(() { _err = false; _k = UniqueKey(); }); } @override void dispose() { _sub?.cancel(); super.dispose(); } @override Widget build(BuildContext context) { if (_err) return Container(color: Colors.black, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.wifi_off, color: Colors.white54), const SizedBox(height: 8), const Text("Loading Ad...", style: TextStyle(color: Colors.white54))])); return Builder(key: _k, builder: (c) => widget.adBuilder(c, widget.adUrl)); } }
class SmartAdContainer extends StatelessWidget { final Widget adContent; final VoidCallback onClose; final String? externalUrl; final double adAspectRatio; const SmartAdContainer({super.key, required this.adContent, required this.onClose, this.externalUrl, this.adAspectRatio = 16/9}); @override Widget build(BuildContext context) { return AspectRatio(aspectRatio: adAspectRatio, child: Container(decoration: BoxDecoration(color: const Color(0xFF151515), border: Border.all(color: Colors.white10)), child: RepaintBoundary(child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Stack(children: [Positioned.fill(child: FittedBox(fit: BoxFit.contain, child: adContent)), Positioned(top: 8, left: 0, right: 0, child: Center(child: AdaptiveCloseAdButton(onPressed: onClose))), Positioned(bottom: 8, left: 8, child: InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FullscreenAdViewer(adContent: adContent, externalAdUrl: externalUrl))), child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.black54, shape: BoxShape.circle, border: Border.all(color: Colors.white30)), child: const Icon(Icons.north_east_rounded, color: Colors.white, size: 16))))]))))); } }
''',

    // =========================================================================
    // 6. Player (Task 23: Cyclic Protection & Task 4: UI Updates)
    // =========================================================================
    'lib/presentation/components/player/smart_media_kit_player.dart': r'''
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
  const SmartMediaKitPlayer({super.key, required this.sources, this.thumbnailUrl, required this.onAspectRatioChanged});
  @override State<SmartMediaKitPlayer> createState() => _SmartMediaKitPlayerState();
}

class _SmartMediaKitPlayerState extends State<SmartMediaKitPlayer> {
  late final Player player; late final VideoController controller;
  SettingsMenuState _menuState = SettingsMenuState.none;
  bool _isAd = false; bool _thumb = true; bool _loop = false; bool _ai = false; 
  
  // Task 23: Cyclic Protection State
  bool _isBlocked = false; // The black screen state
  bool _isError = false; bool _isIntervalAd = false; bool _isFullscreen = false;
  
  Timer? _activeTimer;   // Counts the 4:53 playing time
  Timer? _cooldownTimer; // Counts the 4:53 waiting time
  Timer? _intervalAdTimer;
  
  final Duration _protectionLimit = const Duration(minutes: 4, seconds: 53);

  String _currentAiLang = "English"; String _currentQualityLabel = "Auto"; String _activeUrl = ""; bool _isAutoMode = true; double _currentRatio = 16/9;
  final List<String> _aiLanguages = ["Arabic", "English", "Spanish", "French", "German"];

  @override void initState() {
    super.initState();
    player = Player(configuration: const PlayerConfiguration(bufferSize: 64 * 1024 * 1024));
    controller = VideoController(player);
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeSmartStream());
    Connectivity().onConnectivityChanged.listen((result) { if (_isError && !result.contains(ConnectivityResult.none)) _retryPlayback(); });
    _intervalAdTimer = Timer.periodic(const Duration(minutes: 30), (timer) { if (player.state.playing && !_isIntervalAd && !_isAd && !_isBlocked) _triggerIntervalAd(); });
    player.stream.videoParams.listen((params) { final w = params.w; final h = params.h; if (w != null && h != null && h > 0) { double nr = w / h; if ((nr - _currentRatio).abs() > 0.01) { setState(() => _currentRatio = nr); widget.onAspectRatioChanged(nr); } } });
    
    // Cyclic Logic
    player.stream.playing.listen((p) { 
      if (p && _thumb && mounted) setState(() => _thumb = false); 
      if (p) _startActiveTimer(); else _pauseActiveTimer(); 
    });
    
    player.stream.error.listen((e) { setState(() => _isError = true); });
  }

  // --- Task 23: Cyclic Logic ---
  void _startActiveTimer() {
    if (_isBlocked) return;
    _activeTimer?.cancel();
    _activeTimer = Timer(_protectionLimit, _triggerBlock);
  }

  void _pauseActiveTimer() {
    _activeTimer?.cancel(); 
  }

  void _triggerBlock() {
    if (!mounted) return;
    player.pause();
    setState(() => _isBlocked = true);
    // Start Cooldown
    _cooldownTimer?.cancel();
    _cooldownTimer = Timer(_protectionLimit, _releaseBlock);
  }

  void _releaseBlock() {
    if (!mounted) return;
    setState(() => _isBlocked = false);
    player.play(); // Auto resume
    _startActiveTimer(); // Restart cycle
  }
  // -----------------------------

  Future<void> _initializeSmartStream() async {
    final provider = Provider.of<AppProvider>(context, listen: false);
    String pref = provider.preferredQuality;
    setState(() { _isAutoMode = pref == "Auto"; _currentQualityLabel = pref; });
    if (_isAutoMode) await _autoSelectBestQualityAndLink(); else await _manualSelectQuality(pref);
  }
  Future<void> _autoSelectBestQualityAndLink() async { var q = widget.sources.firstWhere((e) => e.quality == "1080p", orElse: () => widget.sources.first); _playUrl(await _findFastestLink(q.urls)); }
  Future<void> _manualSelectQuality(String q) async { var qm = widget.sources.firstWhere((e) => e.quality == q, orElse: () => widget.sources.first); _playUrl(await _findFastestLink(qm.urls), keepPosition: true); }
  Future<String> _findFastestLink(List<String> urls) async { if (urls.isEmpty) return ""; if (urls.length == 1) return urls.first; Map<String, int> l = {}; await Future.wait(urls.map((url) async { try { final s = Stopwatch()..start(); await http.head(Uri.parse(url)).timeout(const Duration(seconds: 2)); s.stop(); l[url] = s.elapsedMilliseconds; } catch (e) { l[url] = 99999; } })); var e = l.entries.toList(); e.sort((a, b) => a.value.compareTo(b.value)); return e.isEmpty ? urls.first : e.first.key; }
  void _playUrl(String url, {bool keepPosition = false}) { if (url.isEmpty || url == _activeUrl) return; _activeUrl = url; Duration c = player.state.position; setState(() => _isError = false); player.open(Media(url, httpHeaders: {'Cache-Control': 'max-age=3600', 'Range': 'bytes=0-'}), play: true); if (keepPosition) Future.delayed(const Duration(milliseconds: 500), () => player.seek(c)); }
  void _retryPlayback() { _playUrl(_activeUrl, keepPosition: true); }
  void _toggleFullscreen() async { if (_isFullscreen) { await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); setState(() => _isFullscreen = false); } else { await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); if (_currentRatio >= 1) await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]); else await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]); setState(() => _isFullscreen = true); } }
  void _triggerIntervalAd() { if (!mounted) return; player.pause(); setState(() => _isIntervalAd = true); }
  void _closeAd() { if (mounted) { setState(() { _isAd = false; _isIntervalAd = false; }); player.play(); } }
  @override void dispose() { player.dispose(); _activeTimer?.cancel(); _cooldownTimer?.cancel(); _intervalAdTimer?.cancel(); super.dispose(); }

  @override Widget build(BuildContext context) { final p = Provider.of<AppProvider>(context); return AspectRatio(aspectRatio: _currentRatio, child: LayoutBuilder(builder: (c, cs) { return Container(color: Colors.black, child: Stack(alignment: Alignment.center, children: [_isBlocked ? Container(color: Colors.black, width: double.infinity, height: double.infinity, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.lock_clock, color: Colors.white54, size: 50), const SizedBox(height: 16), Text(p.tr('protected'), style: const TextStyle(color: Colors.white, fontSize: 18)), Text(p.tr('wait_msg'), style: const TextStyle(color: Colors.white54))])) : Video(controller: controller, controls: NoVideoControls, fit: BoxFit.contain), if (widget.thumbnailUrl != null) AnimatedOpacity(opacity: _thumb ? 1.0 : 0.0, duration: const Duration(milliseconds: 500), child: IgnorePointer(ignoring: !_thumb, child: UniversalImage(path: widget.thumbnailUrl!, fit: BoxFit.cover, width: double.infinity, height: double.infinity))), if (!_isAd && !_isIntervalAd && _thumb && !player.state.playing && !_isError) Center(child: IconButton(iconSize: 64, icon: const Icon(Icons.play_circle_fill, color: Colors.white), onPressed: () => player.play())), if (_isError) Positioned.fill(child: Container(color: Colors.black87, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.wifi_off, color: Colors.red, size: 50), Text(p.tr('connection_error'), style: const TextStyle(color: Colors.white)), ElevatedButton(onPressed: _retryPlayback, child: Text(p.tr('retry')))]))), if (!_isAd && !_isIntervalAd && !_isBlocked && !_isError) _controls(), if (!_isAd && !_isIntervalAd && _menuState != SettingsMenuState.none) _menu(cs, p), if (_isAd || _isIntervalAd) Positioned.fill(child: SmartAdContainer(adAspectRatio: _currentRatio, onClose: _closeAd, adContent: ReliableAdLoader(adUrl: "https://via.placeholder.com/600x340.png?text=AD", adBuilder: (c, u) => Image.network(u, fit: BoxFit.cover))))])); })); }
  Widget _controls() => Positioned(bottom: 0, left: 0, right: 0, child: Container(color: Colors.black54, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: SafeArea(top: false, child: Row(children: [IconButton(icon: Icon(player.state.playing ? Icons.pause : Icons.play_arrow, color: Colors.white), onPressed: player.playOrPause), IconButton(icon: Icon(_loop ? Icons.repeat_one : Icons.repeat, color: _loop ? Colors.amber : Colors.white), onPressed: () => setState(() { _loop = !_loop; player.setPlaylistMode(_loop ? PlaylistMode.single : PlaylistMode.none); })), const Spacer(), IconButton(icon: Icon(_isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen, color: Colors.white), onPressed: _toggleFullscreen), const SizedBox(width: 8), IconButton(icon: Icon(Icons.settings, color: _menuState != SettingsMenuState.none ? Colors.amber : Colors.white), onPressed: () => setState(() => _menuState = _menuState == SettingsMenuState.none ? SettingsMenuState.main : SettingsMenuState.none))]))));
  Widget _menu(BoxConstraints c, AppProvider p) => Positioned(bottom: 70, right: 20, child: Material(color: Colors.transparent, child: Container(width: min(280.0, c.maxWidth * 0.45), constraints: BoxConstraints(maxHeight: c.maxHeight * 0.6), padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF1E1E1E).withValues(alpha: 0.95), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)), child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: _buildMenuContent(p))))));
  
  List<Widget> _buildMenuContent(AppProvider p) {
    if (_menuState == SettingsMenuState.main) return [
      ListTile(dense: true, title: Text(p.tr('speed'), style: const TextStyle(color: Colors.white)), onTap: () => setState(() => _menuState = SettingsMenuState.speed), trailing: const Icon(Icons.chevron_right, color: Colors.white)), 
      const Divider(color: Colors.white10), 
      ListTile(dense: true, title: Text(p.tr('quality'), style: const TextStyle(color: Colors.white)), subtitle: Text(_currentQualityLabel, style: const TextStyle(color: Colors.amber, fontSize: 10)), onTap: () => setState(() => _menuState = SettingsMenuState.quality), trailing: const Icon(Icons.chevron_right, color: Colors.white)),
      const Divider(color: Colors.white10),
      ListTile(dense: true, title: Text(p.tr('subtitles'), style: const TextStyle(color: Colors.white)), onTap: () => setState(() => _menuState = SettingsMenuState.subtitles), trailing: const Icon(Icons.chevron_right, color: Colors.white)),
    ];
    if (_menuState == SettingsMenuState.speed) return [ListTile(dense: true, title: Text(p.tr('back'), style: const TextStyle(color: Colors.amber)), onTap: () => setState(() => _menuState = SettingsMenuState.main)), ...[0.5, 1.0, 1.5, 2.0].map((s) => ListTile(dense: true, title: Text("${s}x", style: TextStyle(color: player.state.rate == s ? Colors.amber : Colors.white)), onTap: () => setState(() { player.setRate(s); })))];
    if (_menuState == SettingsMenuState.quality) return [ListTile(dense: true, title: Text(p.tr('back'), style: const TextStyle(color: Colors.amber)), onTap: () => setState(() => _menuState = SettingsMenuState.main)), ListTile(dense: true, title: Text(p.tr('auto'), style: const TextStyle(color: Colors.white)), trailing: _isAutoMode ? const Icon(Icons.check, color: Colors.amber, size: 16) : null, onTap: () async { setState(() { _isAutoMode = true; _currentQualityLabel = "Auto"; }); await p.setPreferredQuality("Auto"); await _autoSelectBestQualityAndLink(); }), ...widget.sources.map((q) => ListTile(dense: true, title: Text(q.quality, style: TextStyle(color: Colors.white)), trailing: (!_isAutoMode && _currentQualityLabel == q.quality) ? const Icon(Icons.check, color: Colors.amber, size: 16) : null, onTap: () => setState(() { _isAutoMode = false; _currentQualityLabel = q.quality; _manualSelectQuality(q.quality); })))];
    if (_menuState == SettingsMenuState.subtitles) return [ListTile(dense: true, title: Text(p.tr('back'), style: const TextStyle(color: Colors.amber)), onTap: () => setState(() => _menuState = SettingsMenuState.main)), SwitchListTile(value: _ai, onChanged: (v) => setState(() => _ai = v), title: Text(p.tr('enable_ai'), style: const TextStyle(color: Colors.white)), activeColor: Colors.amber), if (_ai) ...[const Divider(color: Colors.white10), ..._aiLanguages.map((l) => ListTile(dense: true, title: Text(l, style: TextStyle(color: _currentAiLang == l ? Colors.amber : Colors.white)), onTap: () => setState(() => _currentAiLang = l)))]];
    return [];
  }
}
''',

    // =========================================================================
    // 7. Screens (Updated with Tasks 21, 22, 24)
    // =========================================================================
    'lib/presentation/details/components/playlist_sidebar.dart': r'''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/presentation/components/ads/ads_system.dart';

class PlaylistSidebar extends StatefulWidget { 
  final List<SeasonModel> seasons; final SeasonModel currentSeason; final EpisodeModel currentEpisode; final Function(SeasonModel) onSeasonChanged; final Function(EpisodeModel) onEpisodeTap; 
  final bool isDesktop; final bool isLoadingMore; final VoidCallback onLoadMore; 
  const PlaylistSidebar({super.key, required this.seasons, required this.currentSeason, required this.currentEpisode, required this.onSeasonChanged, required this.onEpisodeTap, this.isDesktop = false, required this.isLoadingMore, required this.onLoadMore}); 
  @override State<PlaylistSidebar> createState() => _PlaylistSidebarState(); 
}
class _PlaylistSidebarState extends State<PlaylistSidebar> { 
  bool _ad = true; final ScrollController _sc = ScrollController(); 
  @override void initState() { super.initState(); if (widget.isDesktop) _sc.addListener(() { if (_sc.position.pixels >= _sc.position.maxScrollExtent * 0.9) widget.onLoadMore(); }); } 
  @override Widget build(BuildContext context) { final p = Provider.of<AppProvider>(context); return Container(decoration: BoxDecoration(color: const Color(0xFF1A1A1A), border: Border.all(color: Colors.white10), borderRadius: BorderRadius.circular(8)), child: Column(children: [Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.white10))), child: Column(children: [DropdownButton<SeasonModel>(value: widget.currentSeason, dropdownColor: const Color(0xFF202020), isExpanded: true, items: widget.seasons.map((s) => DropdownMenuItem(value: s, child: Text(s.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white)))).toList(), onChanged: (v) { if (v != null) widget.onSeasonChanged(v); }), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(p.tr('autoplay'), style: const TextStyle(color: Colors.grey)), Switch(value: p.isAutoplayEnabled, onChanged: (v) => p.toggleAutoplay(v), activeColor: Colors.amber)])])), if (_ad) Padding(padding: const EdgeInsets.all(8.0), child: SmartAdContainer(adAspectRatio: 320/100, onClose: () => setState(() => _ad = false), externalUrl: "https://google.com", adContent: Image.network("https://via.placeholder.com/320x100", fit: BoxFit.cover))), Expanded(child: _list())])); } 
  Widget _list() => ListView.builder(controller: widget.isDesktop ? _sc : null, shrinkWrap: !widget.isDesktop, padding: const EdgeInsets.only(bottom: 120), physics: widget.isDesktop ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(), itemCount: widget.currentSeason.episodes.length + (widget.isLoadingMore ? 1 : 0), itemBuilder: (c, i) { if (i == widget.currentSeason.episodes.length) return const Center(child: CircularProgressIndicator(color: Colors.amber)); final e = widget.currentSeason.episodes[i]; final sel = e.id == widget.currentEpisode.id; return InkWell(onTap: () => widget.onEpisodeTap(e), child: Container(padding: const EdgeInsets.all(8), color: sel ? Colors.white10 : Colors.transparent, child: Row(children: [SizedBox(width: 100, height: 60, child: UniversalImage(path: e.thumbnailUrl ?? "")), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(e.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: sel ? Colors.amber : Colors.white)), Text(e.duration, style: const TextStyle(color: Colors.grey, fontSize: 12))]))]))); }); 
}
''',

    // Task 24: Dynamic Grid Math
    'lib/presentation/details/components/lazy_horizontal_section.dart': r'''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/data/mock_data.dart';
import 'package:my_video_project/presentation/common/view_all_screen.dart';
import 'package:my_video_project/presentation/details/movie_details_screen.dart';

class LazyHorizontalSection extends StatefulWidget { final String title; final List<MovieSnippet> initialMovies; final Future<List<MovieSnippet>> Function() onLoadMore; const LazyHorizontalSection({super.key, required this.title, required this.initialMovies, required this.onLoadMore}); @override State<LazyHorizontalSection> createState() => _LazyHorizontalSectionState(); }
class _LazyHorizontalSectionState extends State<LazyHorizontalSection> { late List<MovieSnippet> _m; final ScrollController _sc = ScrollController(); bool _load = false; bool _more = true; @override void initState() { super.initState(); _m = List.from(widget.initialMovies); _sc.addListener(() { if (_sc.position.pixels >= _sc.position.maxScrollExtent * 0.8 && !_load && _more) _fetch(); }); } Future<void> _fetch() async { setState(() => _load = true); final n = await widget.onLoadMore(); if (mounted) setState(() { if (n.isEmpty) _more = false; else _m.addAll(n); _load = false; }); } 
  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Row(children: [Container(width: 4, height: 20, color: Colors.amber), const SizedBox(width: 8), Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), const Spacer(), TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ViewAllScreen(title: widget.title, movies: _m))), child: Text(p.tr('view_all')))])), 
      const SizedBox(height: 12), 
      LayoutBuilder(builder: (c, cs) {
        double screenWidth = MediaQuery.of(context).size.width;
        int itemsToShow = (screenWidth / 150).floor().clamp(3, 8);
        double itemWidth = (screenWidth - 48) / itemsToShow; 
        return SizedBox(height: (itemWidth * 1.5) + 65, child: ListView.separated(controller: _sc, scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 16), itemCount: _m.length + (_load ? 1 : 0), separatorBuilder: (_,__) => const SizedBox(width: 10), itemBuilder: (c, i) { 
          if (i == _m.length) return const Center(child: CircularProgressIndicator(color: Colors.amber)); final m = _m[i]; 
          return InkWell(onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: MockData.allMovies.first))); }, child: SizedBox(width: itemWidth, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ClipRRect(borderRadius: BorderRadius.circular(8), child: UniversalImage(path: m.imageUrl, fit: BoxFit.cover)), const SizedBox(height: 6), Text(m.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontSize: 12))]))); 
        }));
      })
    ]); 
  } 
}
''',

    'lib/presentation/details/movie_details_screen.dart': r'''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
import 'package:my_video_project/core/theme/app_styles.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/components/expandable_text.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/data/mock_data.dart';
import 'package:my_video_project/presentation/components/buttons/action_icon_button.dart';
import 'package:my_video_project/presentation/components/player/smart_media_kit_player.dart';
import 'package:my_video_project/presentation/details/components/playlist_sidebar.dart';
import 'package:my_video_project/presentation/details/components/lazy_horizontal_section.dart';

class MovieDetailsScreen extends StatefulWidget { final MovieModel movie; const MovieDetailsScreen({super.key, required this.movie}); @override State<MovieDetailsScreen> createState() => _MovieDetailsScreenState(); }
class _MovieDetailsScreenState extends State<MovieDetailsScreen> { 
  late ScrollController _sc; late SeasonModel _sea; late EpisodeModel _ep; double _currentAspectRatio = 16/9; 
  @override void initState() { super.initState(); _sc = ScrollController(); _sea = widget.movie.seasons.isNotEmpty ? widget.movie.seasons.first : SeasonModel(id: '0', title: 'No Seasons', episodes: []); _ep = _sea.episodes.isNotEmpty ? _sea.episodes.first : EpisodeModel(id: '0', title: 'No Episode', duration: '', seasonNumber: 0, episodeNumber: 0, sources: []); } 
  void _updateLayoutForVideo(double ratio) { if (mounted && (_currentAspectRatio - ratio).abs() > 0.01) setState(() => _currentAspectRatio = ratio); }

  void _showInfoDialog(BuildContext context, AppProvider p) {
    showDialog(context: context, builder: (c) => AlertDialog(
      backgroundColor: const Color(0xFF202020),
      title: Center(child: Text(p.tr('content_note'), style: const TextStyle(color: Colors.white))),
      content: Text(p.tr('content_desc'), style: const TextStyle(color: Colors.white70), textAlign: TextAlign.center),
      actions: [TextButton(onPressed: () => Navigator.pop(c), child: Text(p.tr('close')))]
    ));
  }

  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(p.tr('watch')), centerTitle: true, 
        backgroundColor: Colors.transparent, elevation: 0,
        leading: const BackButton(color: Colors.white),
        actions: [IconButton(icon: const Icon(Icons.info_outline, color: Colors.white), onPressed: () => _showInfoDialog(context, p)), const SizedBox(width: 8)],
      ),
      body: LayoutBuilder(builder: (c, cs) => cs.maxWidth > 900 ? _desk(p) : _mob(p))
    ); 
  }
  
  Widget _mob(AppProvider p) => SingleChildScrollView(controller: _sc, child: Column(children: [AspectRatio(aspectRatio: _currentAspectRatio, child: SmartMediaKitPlayer(sources: _ep.sources, thumbnailUrl: _ep.thumbnailUrl, onAspectRatioChanged: _updateLayoutForVideo)), Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_info(true, p), const SizedBox(height: 24), _over(), const Divider(color: Colors.white10, height: 48), Text(p.tr('episodes'), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 12), PlaylistSidebar(seasons: widget.movie.seasons, currentSeason: _sea, currentEpisode: _ep, onSeasonChanged: (s) => setState(() => _sea = s), onEpisodeTap: (e) => setState(() => _ep = e), isLoadingMore: false, onLoadMore: (){}), const SizedBox(height: 32), _recs(p)]))]));
  Widget _desk(AppProvider p) { return LayoutBuilder(builder: (context, constraints) { double availableWidth = constraints.maxWidth - 48; double playerWidthShare = _currentAspectRatio < 1.0 ? 0.45 : 0.65; double playerWidth = availableWidth * playerWidthShare; double playerHeight = playerWidth / _currentAspectRatio; double listWidth = availableWidth - playerWidth - 24; return SingleChildScrollView(child: Padding(padding: const EdgeInsets.all(24), child: Column(children: [Row(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(width: playerWidth, child: Column(children: [SizedBox(height: playerHeight, child: SmartMediaKitPlayer(sources: _ep.sources, onAspectRatioChanged: _updateLayoutForVideo)), const SizedBox(height: 20), _info(false, p)])), const SizedBox(width: 24), SizedBox(width: listWidth, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(height: playerHeight, child: PlaylistSidebar(isDesktop: true, seasons: widget.movie.seasons, currentSeason: _sea, currentEpisode: _ep, onSeasonChanged: (s) => setState(() => _sea = s), onEpisodeTap: (e) => setState(() => _ep = e), isLoadingMore: false, onLoadMore: (){})), const SizedBox(height: 20), Text(p.tr('overview'), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), const SizedBox(height: 8), _over()]))]), const SizedBox(height: 40), _recs(p)]))); }); }
  Widget _info(bool mob, AppProvider p) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.movie.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: mob ? AppStyles.headlineMedium : AppStyles.headlineLarge), const SizedBox(height: 12), Row(children: [const Icon(Icons.star, color: Colors.amber, size: 18), const Text(" 9.8", style: TextStyle(color: Colors.greenAccent))]), const SizedBox(height: 20), SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [ActionIconButton(icon: Icons.add, label: "List", onTap: (){}), const SizedBox(width: 16), ActionIconButton(icon: Icons.share, label: "Share", onTap: (){}), const SizedBox(width: 16), ActionIconButton(icon: Icons.flag, label: "Report", onTap: (){}), const SizedBox(width: 16), ActionIconButton(icon: Icons.alarm, label: "Remind", onTap: (){})]))]);
  Widget _over() => ExpandableText(text: widget.movie.overview);
  Widget _recs(AppProvider p) => LazyHorizontalSection(title: p.tr('recommendations'), initialMovies: MockData.allMovies.take(5).map((m) => MovieSnippet(id: m.id.toString(), imageUrl: m.posterPath, title: m.title)).toList(), onLoadMore: () async => []);
}
''',

    'lib/presentation/home/home_screen.dart': r'''
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/data/mock_data.dart';
import 'package:my_video_project/presentation/details/components/lazy_horizontal_section.dart';
import 'package:my_video_project/presentation/details/movie_details_screen.dart';
import 'package:my_video_project/presentation/notifications/notifications_screen.dart';
class HomeScreen extends StatelessWidget { const HomeScreen({super.key}); static const Map<String, dynamic> _heroData = { 'title': 'Flutter Series', 'isExternalAd': false, 'externalUrl': 'https://google.com' }; void _handleVisit(BuildContext context) { if (_heroData['isExternalAd']) { launchUrl(Uri.parse(_heroData['externalUrl'])); } else { Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: MockData.allMovies.first))); } } @override Widget build(BuildContext context) { final p = Provider.of<AppProvider>(context); return Scaffold(extendBodyBehindAppBar: true, appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, actions: [IconButton(icon: const Icon(Icons.notifications_none, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()))), const SizedBox(width: 16)]), body: SingleChildScrollView(child: Column(children: [SizedBox(height: MediaQuery.of(context).size.height * 0.6, width: double.infinity, child: Stack(fit: StackFit.expand, children: [const UniversalImage(path: "https://via.placeholder.com/1920x1080?text=Featured+Content", fit: BoxFit.cover), Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.black, Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.center))), Positioned(bottom: 40, left: 20, right: 20, child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [Text(_heroData['title'], style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold), textAlign: TextAlign.center), const SizedBox(height: 16), ElevatedButton.icon(onPressed: () => _handleVisit(context), icon: const Icon(Icons.north_east, color: Colors.black, size: 16), label: Text(p.tr('visit')), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)))]))])), const SizedBox(height: 24), _sec(p.tr('trending')), const SizedBox(height: 24), _sec(p.tr('new_releases')), const SizedBox(height: 40)]))); } Widget _sec(String t) => LazyHorizontalSection(title: t, initialMovies: MockData.allMovies.map((m) => MovieSnippet(id: m.id.toString(), imageUrl: m.posterPath, title: m.title)).toList(), onLoadMore: () async => []); }
''',

    // Task 21: Back Button Logic Fix
    // Task 24: Grid Math Fix
    'lib/presentation/search/search_screen.dart': r'''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
import 'package:my_video_project/data/mock_data.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/presentation/details/movie_details_screen.dart';
class SearchScreen extends StatefulWidget { const SearchScreen({super.key}); @override State<SearchScreen> createState() => _S(); }
class _S extends State<SearchScreen> { 
  List<MovieModel> _filt = []; 
  @override void initState() { super.initState(); _filt = MockData.allMovies; } 
  void _run(String k) => setState(() => _filt = k.isEmpty ? MockData.allMovies : MockData.allMovies.where((e) => e.title.toLowerCase().contains(k.toLowerCase())).toList()); 
  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.background, 
      appBar: AppBar(
        title: Text(p.tr('search')), centerTitle: true, 
        backgroundColor: Colors.transparent, elevation: 0,
        // Task 21: Smart Back Logic
        leading: BackButton(color: Colors.white, onPressed: () {
          if (p.navIndex != 0) p.setNavIndex(0); else Navigator.pop(context);
        }), 
      ),
      body: Padding(padding: const EdgeInsets.all(16), child: Column(children: [TextField(onChanged: _run, style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: p.tr('search'), hintStyle: const TextStyle(color: Colors.grey), prefixIcon: const Icon(Icons.search, color: Colors.grey), filled: true, fillColor: const Color(0xFF202020), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none))), const SizedBox(height: 20), Expanded(child: LayoutBuilder(builder: (c, cs) { 
        int cnt = (cs.maxWidth / 150).floor().clamp(3, 8); 
        // Task 24: Math for Ratio (Width / (HeightImg + TextHeight))
        double itemW = (cs.maxWidth - (cnt - 1) * 16) / cnt;
        double itemH = (itemW * 1.5) + 65; 
        double ratio = itemW / itemH;
        return GridView.builder(padding: const EdgeInsets.only(bottom: 120), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cnt, childAspectRatio: ratio, crossAxisSpacing: 16, mainAxisSpacing: 16), itemCount: _filt.length, itemBuilder: (c, i) => InkWell(onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: _filt[i]))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ClipRRect(borderRadius: BorderRadius.circular(8), child: UniversalImage(path: _filt[i].posterPath)), const SizedBox(height: 8), Text(_filt[i].title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 13))]))); }))]))
    ); 
  } 
}
''',

    'lib/presentation/notifications/notifications_screen.dart': r'''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/data/mock_data.dart';
import 'package:my_video_project/presentation/details/movie_details_screen.dart';
class NotificationsScreen extends StatelessWidget { const NotificationsScreen({super.key});
  @override Widget build(BuildContext context) { final manager = Provider.of<AppProvider>(context); return Scaffold(backgroundColor: AppColors.background, appBar: AppBar(title: Text(manager.tr('notifications')), centerTitle: true, leading: const BackButton(color: Colors.white), backgroundColor: Colors.transparent), body: !manager.notificationsEnabled ? const Center(child: Text("Disabled", style: TextStyle(color: Colors.grey))) : (manager.notifications.isEmpty ? const Center(child: Text("No notifications", style: TextStyle(color: Colors.grey))) : ListView.separated(padding: const EdgeInsets.all(16), itemCount: manager.notifications.length, separatorBuilder: (_,__) => const Divider(color: Colors.white10), itemBuilder: (c, i) { final n = manager.notifications[i]; return ListTile(onTap: () { if (n.payload != null) Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: MockData.allMovies.first))); }, contentPadding: EdgeInsets.zero, leading: SizedBox(width: 50, height: 75, child: ClipRRect(borderRadius: BorderRadius.circular(8), child: n.imageUrl != null ? UniversalImage(path: n.imageUrl!, fit: BoxFit.cover) : Container(color: Colors.white10, child: const Icon(Icons.notifications, color: AppColors.primary)))), title: Text(n.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), subtitle: Text(n.body, style: const TextStyle(color: Colors.grey), maxLines: 2, overflow: TextOverflow.ellipsis), trailing: Text(n.time, style: const TextStyle(color: Colors.grey, fontSize: 10))); }))); }
}
''',

    // Task 21: Smart Back Button
    // Task 22: Layout Fix & UTF-8 Check
    'lib/presentation/settings/settings_screen.dart': r'''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
class SettingsScreen extends StatelessWidget { const SettingsScreen({super.key}); 
  void _handleClearCache(BuildContext context) async { showDialog(context: context, barrierDismissible: false, builder: (c) => const Center(child: CircularProgressIndicator(color: AppColors.primary))); await Provider.of<AppProvider>(context, listen: false).clearCache(); if (context.mounted) { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(Provider.of<AppProvider>(context, listen: false).tr('cache_cleared')), backgroundColor: Colors.green)); } } 
  void _showAboutApp(BuildContext context, AppProvider p) { showDialog(context: context, builder: (c) => AlertDialog(backgroundColor: const Color(0xFF202020), title: Center(child: Text(p.tr('about_app'), style: const TextStyle(color: Colors.white))), content: Column(mainAxisSize: MainAxisSize.min, children: const [Icon(Icons.play_circle_fill, size: 60, color: AppColors.primary), SizedBox(height: 16), Text("Version 1.0.0", style: TextStyle(color: Colors.white70)), Text("© 2026 All Rights Reserved", style: TextStyle(color: Colors.grey, fontSize: 12))]), actions: [TextButton(onPressed: () => Navigator.pop(c), child: Text(p.tr('close')))])); } 
  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context); 
    return Scaffold(
      backgroundColor: AppColors.background, 
      appBar: AppBar(
        title: Text(p.tr('settings')), centerTitle: true, 
        backgroundColor: Colors.transparent, elevation: 0,
        leading: BackButton(color: Colors.white, onPressed: () {
           if (p.navIndex != 0) p.setNavIndex(0); else Navigator.pop(context);
        }),
      ),
      body: ListView(children: [
        const UserAccountsDrawerHeader(decoration: BoxDecoration(color: Color(0xFF202020)), accountName: Text("Flutter Dev"), accountEmail: Text("dev@example.com"), currentAccountPicture: CircleAvatar(backgroundColor: AppColors.primary, child: Icon(Icons.person, color: Colors.black))), 
        SwitchListTile(value: p.isAutoplayEnabled, onChanged: (v) => p.toggleAutoplay(v), title: Text(p.tr('autoplay'), style: const TextStyle(color: Colors.white)), activeColor: AppColors.primary), 
        SwitchListTile(value: p.notificationsEnabled, onChanged: (v) => p.toggleNotifications(v), title: Text(p.tr('notifications'), style: const TextStyle(color: Colors.white)), activeColor: AppColors.primary), 
        // Task 22: Improved Layout for Language Selector
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              const Icon(Icons.language, color: Colors.white),
              const SizedBox(width: 16),
              Expanded(child: Text(p.tr('language'), style: const TextStyle(color: Colors.white, fontSize: 16))),
              DropdownButton<String>(
                dropdownColor: const Color(0xFF202020), 
                value: p.currentLanguageCode, 
                iconEnabledColor: Colors.white,
                items: ['auto', 'en', 'ar'].map((code) => DropdownMenuItem(value: code, child: Text(p.tr(code), style: const TextStyle(color: Colors.white)))).toList(), 
                onChanged: (v) { if(v != null) p.setLanguage(v); }, 
                underline: Container()
              ),
            ],
          ),
        ),
        const Divider(color: Colors.white24), 
        ListTile(title: Text(p.tr('clear_cache'), style: const TextStyle(color: Colors.white)), leading: const Icon(Icons.cleaning_services, color: Colors.white), onTap: () => _handleClearCache(context)), 
        ListTile(title: Text(p.tr('about_app'), style: const TextStyle(color: Colors.white)), leading: const Icon(Icons.info_outline, color: Colors.white), onTap: () => _showAboutApp(context, p))
      ])); 
  } 
}
''',

    // Task 21: Smart Back Button
    // Task 24: Grid Math
    'lib/presentation/mylist/my_list_screen.dart': r'''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
import 'package:my_video_project/data/mock_data.dart';
import 'package:my_video_project/presentation/details/movie_details_screen.dart';
class MyListScreen extends StatelessWidget { const MyListScreen({super.key}); 
  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context);
    final l = MockData.allMovies.take(6).toList(); 
    return Scaffold(
      backgroundColor: AppColors.background, 
      appBar: AppBar(
        title: Text(p.tr('list')), centerTitle: true, 
        backgroundColor: Colors.transparent, elevation: 0,
        leading: BackButton(color: Colors.white, onPressed: () {
           if (p.navIndex != 0) p.setNavIndex(0); else Navigator.pop(context);
        }),
      ),
      body: Padding(padding: const EdgeInsets.all(16), child: LayoutBuilder(builder: (c, cs) { 
        int cnt = (cs.maxWidth / 150).floor().clamp(3, 8); 
        // Task 24: Math
        double itemW = (cs.maxWidth - (cnt - 1) * 16) / cnt;
        double itemH = (itemW * 1.5) + 65; 
        double ratio = itemW / itemH;
        return GridView.builder(padding: const EdgeInsets.only(bottom: 120), gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cnt, childAspectRatio: ratio, crossAxisSpacing: 16, mainAxisSpacing: 16), itemCount: l.length, itemBuilder: (c, i) => InkWell(onTap: () => Navigator.push(c, MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: l[i]))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ClipRRect(borderRadius: BorderRadius.circular(8), child: UniversalImage(path: l[i].posterPath)), const SizedBox(height: 8), Text(l[i].title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 13))]))); 
    }))); 
  } 
}
''',

    // Task 24: Grid Math
    'lib/presentation/common/view_all_screen.dart': r'''
import 'package:flutter/material.dart';
import 'package:my_video_project/core/components/universal_image.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
import 'package:my_video_project/data/models/movie_models.dart';
import 'package:my_video_project/data/mock_data.dart';
import 'package:my_video_project/presentation/details/movie_details_screen.dart';
class ViewAllScreen extends StatelessWidget { final String title; final List<MovieSnippet> movies; const ViewAllScreen({super.key, required this.title, required this.movies}); @override Widget build(BuildContext context) { return Scaffold(backgroundColor: AppColors.background, appBar: AppBar(backgroundColor: Colors.transparent, title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), leading: const BackButton(color: Colors.white)), body: Padding(padding: const EdgeInsets.all(16.0), child: LayoutBuilder(builder: (c, cs) { int cnt = (cs.maxWidth / 150).floor().clamp(3, 8); double itemW = (cs.maxWidth - (cnt - 1) * 16) / cnt; double itemH = (itemW * 1.5) + 65; double ratio = itemW / itemH; return GridView.builder(padding: const EdgeInsets.only(bottom: 120), itemCount: movies.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: cnt, childAspectRatio: ratio, crossAxisSpacing: 16, mainAxisSpacing: 16), itemBuilder: (c, i) { final m = movies[i]; return InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: MockData.allMovies.first))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [ClipRRect(borderRadius: BorderRadius.circular(8), child: UniversalImage(path: m.imageUrl, fit: BoxFit.cover)), const SizedBox(height: 8), Text(m.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white70, fontSize: 13))])); }); }))); } }
''',

    // Task 21: Wiring up Central Navigation
    'lib/presentation/main_screen.dart': r'''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
import 'package:my_video_project/presentation/home/home_screen.dart';
import 'package:my_video_project/presentation/search/search_screen.dart';
import 'package:my_video_project/presentation/mylist/my_list_screen.dart';
import 'package:my_video_project/presentation/settings/settings_screen.dart';

class MainScreen extends StatelessWidget { 
  const MainScreen({super.key}); 
  final List<Widget> _sc = const [HomeScreen(), SearchScreen(), MyListScreen(), SettingsScreen()]; 
  
  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context); 
    // Task 21: Use Provider Index
    int idx = p.navIndex;
    
    return Scaffold(
      backgroundColor: AppColors.background, 
      body: LayoutBuilder(builder: (c, cs) => cs.maxWidth > 800 ? Row(children: [NavigationRail(backgroundColor: const Color(0xFF101010), selectedIndex: idx, onDestinationSelected: (i) => p.setNavIndex(i), labelType: NavigationRailLabelType.all, selectedLabelTextStyle: const TextStyle(color: AppColors.primary), unselectedLabelTextStyle: const TextStyle(color: Colors.grey), selectedIconTheme: const IconThemeData(color: AppColors.primary), unselectedIconTheme: const IconThemeData(color: Colors.grey), destinations: [NavigationRailDestination(icon: const Icon(Icons.home), label: Text(p.tr('home'))), NavigationRailDestination(icon: const Icon(Icons.search), label: Text(p.tr('search'))), NavigationRailDestination(icon: const Icon(Icons.bookmark), label: Text(p.tr('list'))), NavigationRailDestination(icon: const Icon(Icons.settings), label: Text(p.tr('settings')))]), const VerticalDivider(width: 1, color: Colors.white10), Expanded(child: _sc[idx])]) : _sc[idx]), 
      bottomNavigationBar: MediaQuery.of(context).size.width <= 800 ? BottomNavigationBar(currentIndex: idx, onTap: (i) => p.setNavIndex(i), backgroundColor: const Color(0xFF101010), selectedItemColor: AppColors.primary, unselectedItemColor: Colors.grey, type: BottomNavigationBarType.fixed, items: [BottomNavigationBarItem(icon: const Icon(Icons.home), label: p.tr('home')), BottomNavigationBarItem(icon: const Icon(Icons.search), label: p.tr('search')), BottomNavigationBarItem(icon: const Icon(Icons.bookmark), label: p.tr('list')), BottomNavigationBarItem(icon: const Icon(Icons.settings), label: p.tr('settings'))]) : null
    ); 
  } 
}
''',

    // Task 22: Added Cairo Font
    'lib/main.dart': r'''
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:media_kit/media_kit.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/presentation/main_screen.dart' deferred as main_screen;

void main() { 
  WidgetsFlutterBinding.ensureInitialized(); 
  MediaKit.ensureInitialized(); 
  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (_) => AppProvider())], child: const MyApp())); 
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key}); 
  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Video Project', 
      locale: p.locale,
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black, 
        colorScheme: const ColorScheme.dark(primary: Colors.amber), 
        // Task 22: Fix weird symbols by using Cairo font
        textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0)
      ), 
      home: FutureBuilder(
        future: main_screen.loadLibrary(), 
        builder: (c, s) => s.connectionState == ConnectionState.done ? main_screen.MainScreen() : const Scaffold(backgroundColor: Colors.black)
      )
    ); 
  } 
}
''',
    
    'web/index.html': r'''
<!DOCTYPE html>
<html>
<head>
  <base href="$FLUTTER_BASE_HREF">
  <meta charset="UTF-8">
  <meta content="IE=Edge" http-equiv="X-UA-Compatible">
  <title>Video Project</title>
  <style>
    body { background-color: #000000; margin: 0; padding: 0; overflow: hidden; }
    #loader-msg {
      position: fixed; bottom: 8vh; left: 50%; transform: translateX(-50%);
      width: fit-content; max-width: 80vw;
      background-color: rgba(20, 20, 20, 0.95); color: #ffffff;
      padding: 12px 24px; border-radius: 50px;
      font-family: sans-serif; font-size: 14px; font-weight: 500;
      border: 1px solid rgba(255, 255, 255, 0.15);
      transition: opacity 0.5s ease; z-index: 9999;
      text-align: center; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
    }
    #splash-overlay {
      position: fixed; top: 0; left: 0; width: 100%; height: 100%; 
      z-index: 9998; display: flex; align-items: center; justify-content: center;
      background-color: #000000; transition: opacity 0.5s ease;
    }
  </style>
</head>
<body>
  <div id="splash-overlay">
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" width="100%" height="90vh">
      <circle r="15" fill="none" stroke="#ffffff" stroke-width="12" stroke-dasharray="70 95">
        <animateTransform attributeName="transform" type="rotate" values="0 0 0; 360 0 0" dur="2s" repeatCount="indefinite" />
      </circle>
    </svg>
  </div>
  <div id="loader-msg">جار تحميل التطبيق</div>
  <script>
    const msgDiv = document.getElementById('loader-msg');
    const splashDiv = document.getElementById('splash-overlay');
    let appReady = false;
    setTimeout(() => { if (!appReady) msgDiv.innerText = "أن الأنترنت لديك سيء"; }, 7000);
    setTimeout(() => { if (!appReady) msgDiv.innerText = "جار تحميل التطبيق"; }, 10000);
    window.addEventListener('flutter-first-frame', function() { 
      appReady = true; 
      msgDiv.style.opacity = '0'; splashDiv.style.opacity = '0';
      setTimeout(() => { msgDiv.remove(); splashDiv.remove(); }, 500);
    });
  </script>
  <script src="flutter_bootstrap.js" async></script>
</body>
</html>
''',
  };

  print('🛠️  Writing files with UTF-8 Encoding...');
  Directory('assets/images').createSync(recursive: true);
  Directory('assets/ads').createSync(recursive: true);
  Directory('web').createSync(recursive: true);
  Directory('lib/core/utils').createSync(recursive: true);
  Directory('lib/core/logic').createSync(recursive: true);
  Directory('lib/core/components').createSync(recursive: true);
  Directory('lib/presentation/home').createSync(recursive: true);
  Directory('lib/presentation/components/ads').createSync(recursive: true);
  Directory('lib/data/models').createSync(recursive: true);
  Directory('lib/core/theme').createSync(recursive: true);

  for (var entry in files.entries) {
    final f = File(entry.key);
    if (!f.parent.existsSync()) f.parent.createSync(recursive: true);
    // CRITICAL: Writing with UTF-8 to prevent weird symbols in Arabic text
    f.writeAsStringSync(entry.value, encoding: utf8);
    print('✅ ${entry.key}');
  }
  print('\n💎 DIAMOND BUILD COMPLETE!');
}