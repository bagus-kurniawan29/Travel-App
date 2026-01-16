import 'package:travel_app/widget/iphone14_frame.dart';
import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}
// lib/main.dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.black, // Warna latar belakang di luar iPhone
          body: Center(
            child: IPhone14Frame(
              child: child!, // Ini adalah halaman-halaman aplikasi kamu
            ),
          ),
        );
      },
      home: const MainScreen(),
    );
  }
}
