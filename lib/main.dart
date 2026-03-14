import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

// ✅ Task 10: Phantom Shader Warmup (Kills Initial Jank)
class PhantomWarmup extends StatefulWidget {
  final Widget child; const PhantomWarmup({super.key, required this.child});
  @override State<PhantomWarmup> createState() => _PhantomWarmupState();
}
class _PhantomWarmupState extends State<PhantomWarmup> {
  bool _warmedUp = false;
  @override void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.microtask(() {
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) setState(() => _warmedUp = true);
        });
      });
    });
  }
  @override Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (!_warmedUp)
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.001, // Invisible, but forces GPU compilation
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (c, i) => Container(
                    margin: const EdgeInsets.all(8), height: 100,
                    decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 10)]),
                    child: const CircularProgressIndicator(), // Heavy GPU object
                  )
                )
              )
            )
          )
      ]
    );
  }
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
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black, colorScheme: const ColorScheme.dark(primary: Colors.amber), 
        textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme), appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0)
      ), 
      home: FutureBuilder(
        future: main_screen.loadLibrary(), 
        builder: (c, s) => s.connectionState == ConnectionState.done ? PhantomWarmup(child: main_screen.MainScreen()) : const Scaffold(backgroundColor: Colors.black)
      )
    ); 
  } 
}
