import 'dart:io';
import 'dart:convert';

void main() {
  print('🛑 STARTING THE SNIPER UI PATCH (17 MAY 2026 - 100% COMPLETE)...');
  print('====================================================================');
  print('🔥 TARGET: Injecting Visual Token Extractor in Settings Screen.');
  print('✅ Applying Try-Catch Sandbox Protection in NATIVE KERNEL.');
  print('====================================================================');

  final Map<String, String> files = {
    // =========================================================================
    // 1. REMOTE DATA CONFIG SERVICE (With Sniper Token State)
    // =========================================================================
    'lib/core/services/remote_config_service.dart': r'''
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:my_video_project/data/models/movie_models.dart';

class RemoteConfigService {
  static const String _githubUrl = "https://raw.githubusercontent.com/ben10show1999/club_1/refs/heads/main/config.json"; 
  
  static String? appLogoUrl; static String? globalAdScript; static HeroDataModel? heroData;
  static List<SectionModel> homeSections = []; static Map<String, MovieModel> moviesDb = {};
  static List<MovieSnippet> searchSuggestions = []; static List<MovieSnippet> allSnippets = []; 
  static List<AppNotification> remoteNotifications = [];

  // 🎯 المتغير الجديد لتخزين رمز القناص وعرضه في الشاشة
  static String? sniperWebToken;

  static bool _isLoaded = false;
  static bool get isLoaded => _isLoaded;

  static String _decrypt(String input) { try { if (input.startsWith('ENC:')) { return utf8.decode(base64Decode(input.substring(4))); } return input; } catch (_) { return input; } }

  static Future<bool> fetchConfig({bool forceRefresh = false}) async {
    if (_isLoaded && !forceRefresh) return true;
    try {
      final String cacheBuster = DateTime.now().millisecondsSinceEpoch.toString();
      final Uri targetUri = Uri.parse("$_githubUrl?v=$cacheBuster");
      final response = await http.get(targetUri).timeout(const Duration(seconds: 15));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _parseData(data);
        _isLoaded = true;
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Remote Config Fetch Error: $e");
      return false; 
    }
  }

  static void _parseData(Map<String, dynamic> data) {
    if (data['appConfig'] != null) { appLogoUrl = data['appConfig']['logoUrl']; globalAdScript = data['appConfig']['globalAdScript']; }
    if (data['hero'] != null) { heroData = HeroDataModel.fromJson(data['hero']); }
    if (data['sections'] != null) { homeSections = (data['sections'] as List).map((e) => SectionModel.fromJson(e)).toList(); }
    if (data['searchSuggestions'] != null) { searchSuggestions = (data['searchSuggestions'] as List).map((e) => MovieSnippet.fromJson(e)).toList(); }
    if (data['notifications'] != null) { remoteNotifications = (data['notifications'] as List).map((e) => AppNotification.fromJson(e)).toList(); } 
    moviesDb.clear(); allSnippets.clear();
    if (data['movies_db'] != null) {
      final db = data['movies_db'] as Map<String, dynamic>;
      db.forEach((key, value) { moviesDb[key] = MovieModel.fromJson(value); allSnippets.add(MovieSnippet(id: key, imageUrl: value['posterPath'], title: value['title'])); });
    }
    for (var m in moviesDb.values) {
       for (var s in m.seasons) { for (var e in s.episodes) { for (var q in e.sources) { for(int i = 0; i < q.urls.length; i++) { q.urls[i] = _decrypt(q.urls[i]); } } } }
    }
  }
}
''',

    // =========================================================================
    // 2. CENTRAL APPLICATION APP KERNEL & NATIVE WRAPPER PATCH (With Sandbox Protection)
    // =========================================================================
    'lib/main.dart': r'''
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:media_kit/media_kit.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/services/remote_config_service.dart';
import 'package:my_video_project/presentation/main_screen.dart' deferred as app_shell;

final FlutterLocalNotificationsPlugin _fln = FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await RemoteConfigService.fetchConfig(forceRefresh: true);
}

void main() async { 
  WidgetsFlutterBinding.ensureInitialized(); 
  MediaKit.ensureInitialized(); 

  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAHEohG8X7bUK0LWfTmCVFkPT6SjbJGL08",
        authDomain: "my-video-project-c6696.firebaseapp.com",
        projectId: "my-video-project-c6696",
        storageBucket: "my-video-project-c6696.firebasestorage.app",
        messagingSenderId: "162978515705",
        appId: "1:162978515705:web:f837eb508d1b341bff3028",
        measurementId: "G-S4E8PKQLHX"
      )
    );
    
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
    // 💡 حماية جراحية (Try-Catch) لمنع التطبيق من التحطم في بيئات التطوير المغلقة (IDX Sandbox)
    try {
      await FirebaseMessaging.instance.requestPermission();
      String? myWebToken = await FirebaseMessaging.instance.getToken(vapidKey: "BPvG4GZiDGMHneEmaOgYXY7zRgFMPIwOJw4wuHs_IDjfXlD_cMcw-GftysTarsXk8mrUm5egqvSVpgQBKr1JSXk");
      RemoteConfigService.sniperWebToken = myWebToken; // حفظ الرمز للواجهة
    } catch (e) {
      debugPrint("⚠️ Permission blocked by Browser Sandbox: $e");
    }

    if (!kIsWeb) {
      const AndroidInitializationSettings initAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
      const InitializationSettings initSettings = InitializationSettings(android: initAndroid);
      await _fln.initialize(settings: initSettings);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async { 
      await RemoteConfigService.fetchConfig(forceRefresh: true); 
      if (!kIsWeb && message.notification != null) {
        _fln.show(
          id: message.notification.hashCode,
          title: message.notification!.title,
          body: message.notification!.body,
          notificationDetails: const NotificationDetails(
            android: AndroidNotificationDetails(
              'channel_id', 
              'In-App Notifications', 
              importance: Importance.max, 
              priority: Priority.high
            )
          )
        );
      }
    });

    try { await FirebaseMessaging.instance.subscribeToTopic('all_users'); } catch (_) {}
  } catch (e) { debugPrint('Firebase Init Failed: $e'); }

  await RemoteConfigService.fetchConfig(forceRefresh: true);

  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (_) => AppProvider())], child: const MyApp())); 
}

class MyApp extends StatelessWidget { 
  const MyApp({super.key}); 
  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Video Project Engine V12', 
      locale: p.locale,
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black, 
        colorScheme: const ColorScheme.dark(primary: Colors.amber), 
        textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme), 
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0)
      ), 
      home: FutureBuilder(
        future: app_shell.loadLibrary(), 
        builder: (c, s) => s.connectionState == ConnectionState.done ? app_shell.MainScreen() : const Scaffold(backgroundColor: Colors.black)
      )
    ); 
  } 
}
''',

    // =========================================================================
    // 3. SETTINGS UI LAYER (With Radar Sniper Token UI)
    // =========================================================================
    'lib/presentation/settings/settings_screen.dart': r'''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/core/theme/app_colors.dart';
import 'package:my_video_project/core/services/remote_config_service.dart';

class SettingsScreen extends StatelessWidget { 
  const SettingsScreen({super.key}); 
  
  void _handleClearCache(BuildContext context, AppProvider p) async { 
    if (!p.canClearCache) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(p.tr('cache_limit')), backgroundColor: Colors.redAccent)); return; } 
    showDialog(context: context, barrierDismissible: false, builder: (c) => const Center(child: CircularProgressIndicator(color: AppColors.primary))); 
    await p.clearCache(); 
    if (context.mounted) { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(p.tr('cache_cleared')), backgroundColor: Colors.green)); } 
  } 
  
  void _showAboutApp(BuildContext context, AppProvider p) { 
    showDialog(context: context, builder: (c) => AlertDialog(backgroundColor: const Color(0xFF202020), title: Center(child: Text(p.tr('about_app'), style: const TextStyle(color: Colors.white))), content: Column(mainAxisSize: MainAxisSize.min, children: const [Icon(Icons.play_circle_fill, size: 60, color: AppColors.primary), SizedBox(height: 16), Text("Version 12.0.0", style: TextStyle(color: Colors.white70)), Text("Sniper Master Build", style: TextStyle(color: Colors.grey, fontSize: 12))]), actions: [TextButton(onPressed: () => Navigator.pop(c), child: Text(p.tr('close')))])); 
  } 
  
  @override Widget build(BuildContext context) { 
    final p = Provider.of<AppProvider>(context); 
    return Scaffold(
      backgroundColor: AppColors.background, 
      appBar: AppBar(title: Text(p.tr('settings')), centerTitle: true, backgroundColor: Colors.transparent, elevation: 0, leading: BackButton(color: Colors.white, onPressed: () { if (p.navIndex != 0) { p.setNavIndex(0); } else { Navigator.pop(context); } })), 
      body: ListView(
        children: [
          // 🎯 شاشة الرادار: لوحة عرض رمز متصفحك الخاص بالقنص (تظهر فقط إن تم استخراج الرمز بنجاح)
          if (RemoteConfigService.sniperWebToken != null)
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.5), width: 2)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(children: [Icon(Icons.radar, color: AppColors.primary), SizedBox(width: 8), Text("Device Sniper Token (للنسخ):", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
                  const SizedBox(height: 12),
                  SelectableText(
                    RemoteConfigService.sniperWebToken!, 
                    style: const TextStyle(color: Colors.amber, fontSize: 11, fontFamily: 'monospace')
                  ),
                ]
              )
            ),
            
          const UserAccountsDrawerHeader(decoration: BoxDecoration(color: Color(0xFF202020)), accountName: Text("Flutter Dev"), accountEmail: Text("dev@example.com"), currentAccountPicture: CircleAvatar(backgroundColor: AppColors.primary, child: Icon(Icons.person, color: Colors.black))), 
          SwitchListTile(value: p.isAutoplayEnabled, onChanged: (v) => p.toggleAutoplay(v), title: Text(p.tr('autoplay'), style: const TextStyle(color: Colors.white)), activeTrackColor: AppColors.primary.withValues(alpha: 0.5), activeThumbColor: AppColors.primary), 
          SwitchListTile(value: p.notificationsEnabled, onChanged: (v) => p.toggleNotifications(v), title: Text(p.tr('notifications'), style: const TextStyle(color: Colors.white)), activeTrackColor: AppColors.primary.withValues(alpha: 0.5), activeThumbColor: AppColors.primary), 
          Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Row(children: [const Icon(Icons.language, color: Colors.white), const SizedBox(width: 16), Expanded(child: Text(p.tr('language'), style: const TextStyle(color: Colors.white, fontSize: 16))), DropdownButton<String>(dropdownColor: const Color(0xFF202020), value: p.currentLanguageCode, iconEnabledColor: Colors.white, items: ['auto', 'en', 'ar'].map((code) => DropdownMenuItem(value: code, child: Text(p.tr(code), style: const TextStyle(color: Colors.white)))).toList(), onChanged: (v) { if (v != null) { p.setLanguage(v); } }, underline: Container())])), 
          const Divider(color: Colors.white24), 
          ListTile(title: Text(p.tr('clear_cache'), style: TextStyle(color: p.canClearCache ? Colors.white : Colors.grey)), subtitle: Text("Quota: ${p.remainingCacheClears} left today", style: const TextStyle(color: Colors.amber, fontSize: 10)), leading: Icon(Icons.cleaning_services, color: p.canClearCache ? Colors.white : Colors.grey), trailing: p.canClearCache ? null : const Icon(Icons.lock_clock, color: Colors.redAccent, size: 18), onTap: () => _handleClearCache(context, p)), 
          ListTile(title: Text(p.tr('about_app'), style: const TextStyle(color: Colors.white)), leading: const Icon(Icons.info_outline, color: Colors.white), onTap: () => _showAboutApp(context, p))
        ]
      )
    ); 
  } 
}
'''
  };

  print('🛠️ Writing patched files...');
  
  for (var entry in files.entries) {
    final file = File(entry.key);
    // التأكد من وجود المسار أولاً
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(entry.value, encoding: utf8);
    print('✨ Successfully Patched: ${entry.key}');
  }
  
  print('\n🎯 [PATCH SUCCESS] THE SNIPER UI IS NOW LIVE AND PROTECTED!');
  print('🚀 You can now compile and deploy this to your live hosting.');
}