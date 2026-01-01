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
      // PERBAIKAN ICON DISINI:
      items: const <Widget>[
        Icon(Icons.home, size: 30, color: Colors.white), // Index 0: Home
        Icon(
          Icons.assignment,
          size: 30,
          color: Colors.white,
        ), // Index 1: Discover (Ganti Icons.abc jadi explore)
        Icon(
          Icons.person,
          size: 30,
          color: Colors.white,
        ), // Index 2: Orders (Ganti Icons.person jadi receipt jika halaman Orders)
      ],
      color: Colors.blue,
      buttonBackgroundColor: Colors.blue,
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 500),
      onTap: onTap,
    );
  }
}
