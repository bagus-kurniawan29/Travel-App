import 'package:flutter/material.dart';

class IPhone14Frame extends StatelessWidget {
  final Widget child;

  const IPhone14Frame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 393 / 852, // Aspek rasio asli iPhone 14 Pro
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(55),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          // PERBAIKAN: Gunakan 'child', bukan 'container'
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 1. Background Luar (Bezel)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(55),
                ),
              ),

              // 2. Layar Konten
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(47),
                  child: Container(color: Colors.white, child: child),
                ),
              ),
              // 4. Image Frame
              IgnorePointer(
                child: Image.asset(
                  'assets/frame/iphone Frame.png',
                  fit: BoxFit.fill,
                ),
              ),

              // 5. Home Indicator
              Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 120,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
