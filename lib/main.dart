import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Tambahkan ini
import 'package:travel_app/l10n/app_localizations.dart'; // Tambahkan ini
import 'package:travel_app/widget/iphone14_frame.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = false;
  
  // Ubah dari String ke Locale
  Locale _currentLocale = const Locale('id'); 

  void toggleTheme(bool value) {
    setState(() {
      _isDark = value;
    });
  }

  // Fungsi untuk mengubah bahasa secara global
  void toggleLanguage(String langCode) {
    setState(() {
      _currentLocale = Locale(langCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',

      // Konfigurasi Lokalisasi Utama
      locale: _currentLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Dari file generate arb
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id'), // Indonesia
        Locale('en'), // English
        Locale('ja'), // Jepang
        Locale('zh'), // China
        Locale('ko'), // Korea
        Locale('de'), // Jerman/Eropa
      ],

      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,

      home: MainScreen(
        isDark: _isDark,
        onToggle: toggleTheme,
        // Kirim kode bahasa saat ini ke MainScreen
        currentLang: _currentLocale.languageCode, 
        onLangChange: toggleLanguage,
      ),

      builder: (context, child) {
        final bool isDesktopOrWeb =
            kIsWeb ||
            defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.linux;

        if (isDesktopOrWeb) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: IPhone14Frame(child: child!)),
          );
        }
        return child!;
      },
    );
  }
}