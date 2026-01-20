import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 10),
        child: FloatingActionButton(
          mini: true,
          backgroundColor: Colors.white,
          elevation: 2,
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      appBar: AppBar(title: const Text('Test Screen')),
      body: const Center(child: Text('If you see this shit so it\'s work')),
    );
  }
}
