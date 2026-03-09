import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:media_kit/media_kit.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_video_project/core/logic/app_provider.dart';
import 'package:my_video_project/presentation/main_screen.dart' deferred as main_screen;

void main() { 
  WidgetsFlutterBinding.ensureInitialized(); 
  
  // ✅ Task 8: Micro-task Deferral for heavy init
  Future.microtask(() {
    MediaKit.ensureInitialized(); 
  });
  
  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (_) => AppProvider())], child: const MyApp())); 
}

class MyApp extends StatefulWidget { 
  const MyApp({super.key}); 
  @override State<MyApp> createState() => _MyAppState(); 
}

class _MyAppState extends State<MyApp> {
  bool _isReady = false;

  @override void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    // ✅ Task 8: Proactive Asset Decoding
    precacheImage(const NetworkImage('https://iili.io/q2Ty8N4.webp'), context);
    await main_screen.loadLibrary();
    if (mounted) setState(() => _isReady = true);
  }

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
        textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0)
      ), 
      home: _isReady 
          ? main_screen.MainScreen() 
          : _PhantomWarmUpSplash() // ✅ Task 8: Phantom Shader Compilation
    ); 
  } 
}

// Invisible layer that forces GPU shader compilation during splash screen
class _PhantomWarmUpSplash extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const Center(child: CircularProgressIndicator(color: Colors.amber)),
          Offstage(
            offstage: true,
            child: ListView(
              children: [
                const Text("Shader Warmup", style: TextStyle(shadows: [Shadow(blurRadius: 2)])),
                Slider(value: 0.5, onChanged: (v){}),
                ElevatedButton(onPressed: (){}, child: const Text("Btn")),
                Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [Colors.black, Colors.white])))
              ],
            ),
          )
        ],
      )
    );
  }
}
