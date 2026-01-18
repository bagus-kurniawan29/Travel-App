import 'package:flutter/material.dart';

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
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.blue, // Warna latar navbar
      selectedItemColor: Colors.white, // Warna icon yang DIPILIH (Aktif)
      unselectedItemColor: Colors.white.withOpacity(
        0.6,
      ), // Warna icon yang TIDAK dipilih (lebih redup)
      showSelectedLabels:
          false, // Hilangkan label teks jika ingin mirip curved navbar
      showUnselectedLabels: false, // Hilangkan label teks
      type: BottomNavigationBarType.fixed, // Pastikan posisi icon stabil
      items: const [
        // Index 0: Home
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 30),
          label: 'Home',
        ),
        // Index 1: Discover (Assignment)
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment, size: 30),
          label: 'Discover',
        ),
        // Index 2: Profile (Person)
        BottomNavigationBarItem(
          icon: Icon(Icons.person, size: 30),
          label: 'Profile',
        ),
      ],
    );
  }
}
