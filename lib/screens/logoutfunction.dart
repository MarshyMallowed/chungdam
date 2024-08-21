import 'package:chungdam/screens/authentication/login.dart';
import 'package:flutter/material.dart';


void logoutAndNavigateToLogin(BuildContext context) async {
  // Check if the widget is still mounted
  if (!context.mounted) return;

  // Navigate to the login screen
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const LoginScreen()),
  );
}
