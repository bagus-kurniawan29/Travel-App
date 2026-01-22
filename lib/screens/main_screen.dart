import 'package:flutter/material.dart';
import 'package:travel_app/screens/daftar_ticket.dart';
import 'package:travel_app/screens/home_screen.dart';
import 'package:travel_app/screens/setting.dart';
import '../widget/navbar.dart';

class MainScreen extends StatefulWidget {
  final bool isDark;
  final String currentLang; // Tambahkan ini
  final Function(bool) onToggle;
  final Function(String) onLangChange; // Tambahkan ini

  const MainScreen({
    super.key, 
    required this.isDark, 
    required this.currentLang, 
    required this.onToggle, 
    required this.onLangChange
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(isDark: widget.isDark),
      DaftarTicket(isDark: widget.isDark),
      Settings(
        isDark: widget.isDark, 
        onToggle: widget.onToggle,
        currentLang: widget.currentLang, // Oper ke Settings
        onLangChange: widget.onLangChange, // Oper fungsi ke Settings
      ),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}