import 'package:chungdam/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chungdam/screens/home.dart';
import 'package:chungdam/screens/registrationpage.dart';
import 'package:chungdam/screens/cart_provider.dart';
import 'package:chungdam/screens/firebase_fetcher.dart'; // Ensure this import path is correct
import 'package:shared_preferences/shared_preferences.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isRegistered = prefs.getBool('isRegistered') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(isRegistered: isRegistered),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isRegistered;

  const MyApp({super.key, required this.isRegistered});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chung Dam',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isRegistered ? AuthWrapper() : const RegistrationPage(), //Home(firstName: 'test', phoneNumber:)
    );
  }
}

class AuthWrapper extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to the authentication state
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If the snapshot has data, the user is signed in
        if (snapshot.hasData) {
          return FutureBuilder<Map<String, dynamic>?>(
            future: _firestoreService.getUserByPhoneNumber(snapshot.data!.phoneNumber!),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: Center(child: CircularProgressIndicator()));
              }

              if (userSnapshot.hasError) {
                return Scaffold(body: Center(child: Text('Error: ${userSnapshot.error}')));
              }

              if (!userSnapshot.hasData || userSnapshot.data == null) {
                // If user data is not available, show the login page
                return const LoginScreen();
              }

              // Extract user data
              final userData = userSnapshot.data!;
              final phoneNumber = userData['phoneNumber'] ?? snapshot.data!.phoneNumber!;

              // Navigate to the HomePage with fetched user data
              return Home(
                phoneNumber: phoneNumber,
              );
            },
          );
        } else {
          // Otherwise, show the login page
          return const LoginScreen();
        }
      },
    );
  }
}
