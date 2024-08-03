import 'package:flutter/material.dart';

class BlankPage extends StatelessWidget {
  const BlankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blank Page'),
        backgroundColor: const Color(0xFF0c2344),
      ),
      body: const Center(
        child: Text('Blank Page'),
      ),
    );
  }
}
