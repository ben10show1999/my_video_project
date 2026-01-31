import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:provider/provider.dart';
import 'core/logic/app_provider.dart';
import 'presentation/main_screen.dart' deferred as main_screen;
void main() { WidgetsFlutterBinding.ensureInitialized(); MediaKit.ensureInitialized(); runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (_) => AppProvider())], child: const MyApp())); }
class MyApp extends StatelessWidget { const MyApp({super.key}); @override Widget build(BuildContext context) { return MaterialApp(debugShowCheckedModeBanner: false, title: 'Video Project', theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black, colorScheme: const ColorScheme.dark(primary: Colors.amber), appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0)), home: FutureBuilder(future: main_screen.loadLibrary(), builder: (c, s) => s.connectionState == ConnectionState.done ? main_screen.MainScreen() : const Scaffold(backgroundColor: Colors.black))); } }
