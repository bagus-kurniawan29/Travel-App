import 'package:flutter/material.dart';

class IPhone14Frame extends StatelessWidget {
  final Widget child;

  const IPhone14Frame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 400 / 840,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 💡 Latar belakang putih agar frame menyatu dengan layar
            Container(color: Colors.white),

            // 💡 Clip agar konten tidak keluar dari frame
            ClipRRect(
              borderRadius: BorderRadius.circular(
                20,
              ), // bisa diubah kalau pinggir frame membulat
              child: SafeArea(
                minimum: const EdgeInsets.only(top: 50.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: child,
                ),
              ),
            ),

            // 💡 Frame iPhone
            IgnorePointer(
              child: Image.asset(
                'assets/frame/iphone Frame.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
