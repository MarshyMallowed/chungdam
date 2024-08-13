// ignore: file_names
import 'package:chungdam/screens/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void logoutAndNavigateToLogin(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Check if the widget is still mounted
  if (!context.mounted) return;

  // Navigate to the login screen
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => const LoginScreen()),
  );
}
