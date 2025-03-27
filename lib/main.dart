import 'package:flutter/material.dart';
import 'presentation/pages/main/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yami - E-commerce de Alimentos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
          primary: const Color(0xFF4CAF50),
          secondary: const Color(0xFF2196F3),
        ),
        useMaterial3: true,
      ),
      home: const MainPage(),
      routes: {
        '/main': (context) => const MainPage(),
      },
    );
  }
}
