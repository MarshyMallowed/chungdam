// ignore: file_names
import 'package:chungdam/screens/authentication/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void logoutAndNavigateToLogin(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await FirebaseAuth.instance.signOut();

  if (!context.mounted) return; // Check if the widget is still mounted

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
  );
}