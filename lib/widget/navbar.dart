import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: currentIndex,
      height: 60.0,
      items: const <Widget>[
        Icon(Icons.home, size: 30, color: Colors.white),
        Icon(Icons.explore, size: 30, color: Colors.white),
        Icon(Icons.assignment, size: 30, color: Colors.white),
        Icon(Icons.favorite, size: 30, color: Colors.white),
      ],
      color: Colors.blue, // Warna bar
      buttonBackgroundColor: Colors.blue,
      backgroundColor: Colors.transparent, 
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 500),
      onTap: onTap,
    );
  }
}