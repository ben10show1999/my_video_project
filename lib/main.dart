import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'presentation/screens/home_screen.dart'; // 👈 البداية الصحيحة

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
      title: 'Movies App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(primary: Colors.amber),
      ),
      // 🔥 الآن التطبيق يبدأ من الرئيسية (والسبلاش يتم في HTML)
      home: const HomeScreen(),
    );
  }
}
