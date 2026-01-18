import 'package:flutter/foundation.dart'; // 1. WAJIB IMPORT INI (untuk cek platform)
import 'package:flutter/material.dart';
import 'package:travel_app/widget/iphone14_frame.dart'; // Pastikan path ini benar
import 'screens/main_screen.dart'; // Pastikan path ini benar

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',

      // LOGIKA UTAMA DISINI
      builder: (context, child) {
        // 1. Definisikan apakah ini berjalan di Desktop/Web
        // kIsWeb = true jika dibuka di browser
        // defaultTargetPlatform = cek OS (Windows, Mac, Linux)
        final bool isDesktopOrWeb =
            kIsWeb ||
            defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.linux;

        // 2. Jika Desktop/Web -> Pakai Frame iPhone
        if (isDesktopOrWeb) {
          return Scaffold(
            backgroundColor:
                Colors.black, // Latar belakang hitam ala presentasi
            body: Center(
              // Bungkus aplikasi dengan Frame iPhone
              child: IPhone14Frame(child: child!),
            ),
          );
        }
        // 3. Jika di HP beneran (Android/iOS Native) -> Tampilkan Full Screen (Tanpa Frame)
        else {
          return child!;
        }
      },

      home: const MainScreen(),
    );
  }
}
