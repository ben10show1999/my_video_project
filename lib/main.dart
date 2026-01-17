import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'presentation/screens/home_screen.dart'; // 👈 استدعاء الرئيسية مباشرة

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App', // الاسم الذي يظهر في التبويب
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(primary: Colors.red), // لون أحمر مثل نتفليكس
      ),
      // 🔥 بما أن الـ HTML قام بمهمة السبلاش، فلاتر يبدأ مباشرة بالرئيسية
      home: const HomeScreen(),
    );
  }
}
