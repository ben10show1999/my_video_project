import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:media_kit/media_kit.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:web/web.dart' as web;
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

  // 🎯 القنص المعماري الفائق: التقاط المعرف عبر 3 طبقات فحص قبل إقلاع المحرك ومسح الرابط
  if (kIsWeb) {
    try {
      String? extractedId = Uri.base.queryParameters['targetId'];
      
      if (extractedId == null) {
        final String fullHref = web.window.location.href;
        final Uri parsedUri = Uri.parse(fullHref);
        if (parsedUri.queryParameters.containsKey('targetId')) {
          extractedId = parsedUri.queryParameters['targetId'];
        } else {
          final String fragment = parsedUri.fragment;
          if (fragment.contains('targetId=')) {
            final RegExp match = RegExp(r'targetId=([^&]+)');
            extractedId = match.firstMatch(fragment)?.group(1);
          }
        }
      }
      
      if (extractedId != null && extractedId.isNotEmpty) {
        RemoteConfigService.pendingTargetId = extractedId;
        debugPrint('🎯 Ultra Early Snatcher Captured Target ID: $extractedId');
      }
    } catch (e) {
      debugPrint('Early Snatcher Exception Blocked: $e');
    }
  }

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
    
    try {
      await FirebaseMessaging.instance.requestPermission();
      String? myWebToken = await FirebaseMessaging.instance.getToken(vapidKey: "BPvG4GZiDGMHneEmaOgYXY7zRgFMPIwOJw4wuHs_IDjfXlD_cMcw-GftysTarsXk8mrUm5egqvSVpgQBKr1JSXk");
      RemoteConfigService.sniperWebToken = myWebToken; 
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
      
      if (message.notification != null) {
        if (!kIsWeb) {
          _fln.show(
            id: message.notification.hashCode,
            title: message.notification!.title,
            body: message.notification!.body,
            notificationDetails: const NotificationDetails(
              android: AndroidNotificationDetails('channel_id', 'In-App', importance: Importance.max, priority: Priority.high)
            )
          );
        } else {
          try {
            if (web.Notification.permission == 'granted') {
              web.Notification(
                message.notification!.title ?? 'إشعار جديد',
                web.NotificationOptions(
                  body: message.notification!.body ?? '',
                  icon: message.notification!.android?.imageUrl ?? 'https://iili.io/q2Ty8N4.webp'
                )
              );
            }
          } catch (e) {
            debugPrint('Web OS Notification Engine Error: $e');
          }
        }
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
      title: 'Video Project Engine V13', 
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
