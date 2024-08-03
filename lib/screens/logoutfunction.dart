// ignore: file_names
import 'package:chungdam/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void logoutAndNavigateToLogin(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isRegistered', false); // Update registration status
  await FirebaseAuth.instance.signOut();

  if (!context.mounted) return; // Check if the widget is still mounted

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
  );
}