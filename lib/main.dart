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
    await FirebaseMessaging.instance.requestPermission();
    
    // 💡 مُهمة (4): حقن مفتاح VAPID بشكل صحيح داخل بيئة التهيئة لاستلام الـ Token في المتصفح المباشر بنجاح
    await FirebaseMessaging.instance.getToken(vapidKey: "BPvG4GZiDGMHneEmaOgYXY7zRgFMPIwOJw4wuHs_IDjfXlD_cMcw-GftysTarsXk8mrUm5egqvSVpgQBKr1JSXk");

    // 💡 الطبقة الأصلية (Native Bridge) لإجبار عرض الإشعار والـ App مفتوح
    if (!kIsWeb) {
      const AndroidInitializationSettings initAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
      const InitializationSettings initSettings = InitializationSettings(android: initAndroid);
      
      // 🔥 مُهمة (5): إصلاح الخطأ 1 و 3 عبر تمرير الإعدادات كـ Named Parameter 'settings:'
      await _fln.initialize(settings: initSettings);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async { 
      await RemoteConfigService.fetchConfig(forceRefresh: true); 
      // إظهار إشعار النظام المباشر فقط إذا لم نكن في الويب (حيث يتكفل الـ SW بذلك)
      if (!kIsWeb && message.notification != null) {
        
        // 🔥 مُهمة (5): إصلاح الخطأ 2 و 4 عبر تحويل كافة معاملات دالة show إلى Named Parameters
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

    try { await FirebaseMessaging.instance.subscribeToTopic('all_users'); } catch (_) { /* Bypassed cleanly on pure Web */ }
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
      title: 'Video Project Engine V11', 
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
