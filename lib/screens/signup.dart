import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:chungdam/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignUpScreen extends StatefulWidget {
  final String phoneNumber;
  final String phoneCNumber;
  const SignUpScreen({super.key, required this.phoneNumber, required this.phoneCNumber});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();

Future<bool> isPhoneNumberUnique(String phoneNumber) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    return query.docs.isEmpty; // Returns true if the phone number is not in the database
  }
    Future<void> _submitData() async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final name = '$firstName $lastName';
    final password = _passwordController.text;

    try {
      // Check if the phone number is unique
      bool isUnique = await isPhoneNumberUnique(widget.phoneNumber);

      if (!isUnique) {
        // Phone number is already registered
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This phone number is already registered.')),
        );
        return;
      }

      // Proceed to store user data if the phone number is unique
      await FirebaseFirestore.instance.collection('users').add({
        'firstName': firstName,
        'lastName': lastName,
        'name': name,
        'password': password,
        'phoneNumber': widget.phoneNumber,
        'completeNumber': widget.phoneCNumber,
        'createdAt': Timestamp.now(), // Optional: Store the time of creation
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isRegistered', true);
      if (kDebugMode) {
        print('User data stored successfully');
      }
      Navigator.push(
            
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            firstName: firstName,
            phoneNumber: widget.phoneNumber,
          ),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Failed to store user data: $e');
      }
      if (context.mounted) { // Check if the widget is still mounted
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create account. Please try again.')),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Image.asset(
                'assets/logo.png',
                height: 300,
              ),
              const SizedBox(height: 20), // Adjust height to position content correctly
              const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'via',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (kDebugMode) {
                        print("Google icon tapped");
                      }
                    },
                    child: Image.asset(
                      'assets/google_icon.png',
                      height: 30,
                      width: 30,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      if (kDebugMode) {
                        print('Facebook icon tapped');
                      }
                    },
                    child: Image.asset(
                      'assets/facebook_icon.png',
                      height: 30,
                      width:30,
                    )
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'or',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Expanded(
                      child: Divider (
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: 
                  _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                ),
                child: const Text(
                  'Create Account',
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Already have an account?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: '  LOGIN HERE',
                      style: const TextStyle(
                        color: Color(0xFFCD7F32),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                        },
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
