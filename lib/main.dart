import 'package:travel_app/screens/home_screen.dart';
import 'package:travel_app/widget/iphone14_frame.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Iphone 14 Frame',
      home:
          Platform.isAndroid || Platform.isIOS
              ? const MainScreen()
              : IPhone14Frame(child: const MainScreen()),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}