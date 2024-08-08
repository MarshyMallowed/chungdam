import 'package:flutter/material.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant'),
        backgroundColor: const Color(0xFF0c2344),
      ),
      body: const Center(
        child: Text('Restaurant Page'),
      ),
    );
  }
}
