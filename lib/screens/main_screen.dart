import 'package:flutter/material.dart';
import 'package:travel_app/screens/daftar_ticket.dart';
import 'package:travel_app/screens/home_screen.dart';
import 'package:travel_app/screens/setting.dart';
import '../widget/navbar.dart';

class MainScreen extends StatefulWidget {
  final bool isDark;
  final String currentLang;
  final Function(bool) onToggle;
  final Function(String) onLangChange;

  const MainScreen({
    super.key,
    required this.isDark,
    required this.currentLang,
    required this.onToggle,
    required this.onLangChange,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  String getLanguageCode(String languageName) {
    switch (languageName) {
      case 'English':
        return 'en';
      case 'Japan':
        return 'ja';
      case 'Chinese':
        return 'zh-cn';
      default:
        return 'id';
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(isDark: widget.isDark, onToggle: widget.onToggle, onLangChange: widget.onLangChange,),
      DaftarTicket(isDark: widget.isDark, onToggle: widget.onToggle, onLangChange: widget.onLangChange),
      Settings(
        isDark: widget.isDark,
        onToggle: widget.onToggle,
        currentLang: widget.currentLang,
        onLangChange: widget.onLangChange,
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
