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
  final int initialIndex;

  const MainScreen({
    super.key,
    required this.isDark,
    required this.currentLang,
    required this.onToggle,
    required this.onLangChange,
    this.initialIndex = 0,
  });

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    selectedIndex = widget.initialIndex;
  }

  void setTab(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        isDark: widget.isDark,
        onToggle: widget.onToggle,
        onLangChange: widget.onLangChange,
      ),
      DaftarTicket(
        isDark: widget.isDark,
        onToggle: widget.onToggle,
        onLangChange: widget.onLangChange,
      ),
      Settings(
        isDark: widget.isDark,
        currentLang: widget.currentLang,
        onToggle: widget.onToggle,
        onLangChange: widget.onLangChange,
      ),
    ];

    return Scaffold(
      extendBody: true,

      body: IndexedStack(index: selectedIndex, children: pages),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
