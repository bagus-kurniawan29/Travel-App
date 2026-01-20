import 'package:flutter/foundation.dart'; 
import 'package:flutter/material.dart';
import 'package:travel_app/widget/iphone14_frame.dart'; 
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
      title: 'Travel App',
      builder: (context, child) {
        final bool isDesktopOrWeb =
            kIsWeb ||
            defaultTargetPlatform == TargetPlatform.windows ||
            defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.linux;
        if (isDesktopOrWeb) {
          return Scaffold(
            backgroundColor:
                Colors.black, 
            body: Center(
              
              child: IPhone14Frame(child: child!),
            ),
          );
        }
        else {
          return child!;
        }
      },
      home: const MainScreen(),
    );
  }
}
