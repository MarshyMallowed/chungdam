import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chungdam/screens/home.dart';
import 'login.dart';
import 'package:bcrypt/bcrypt.dart';

class SignUpScreen extends StatefulWidget {
  final String phoneNumber;
  final String phoneCNumber;
  const SignUpScreen({super.key, required this.phoneNumber, required this.phoneCNumber});

  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  

  Future<String> _showCreatePasswordDialog() async {
    String password = '';
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create a Password'),
          content: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
            ),
            TextButton(
              child: Text('Create'),
              onPressed: () {
                if (_passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a password.')),
                  );
                } else {
                  password = _passwordController.text;
                  Navigator.of(context).pop(); // Close dialog
                }
              },
            ),
          ],
        );
      },
    );

    return password;
  }
  Future<bool> isPhoneNumberUnique(String phoneNumber) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    return query.docs.isEmpty; // Returns true if the phone number is not in the database
  }
  
  Future<void> _signUpWithGoogle() async {
  try {
  // Trigger the Google Sign-In flow
  final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  bool isUnique = await isPhoneNumberUnique(widget.phoneNumber);
  
  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Sign in with the credential
  final UserCredential userCredential = await _auth.signInWithCredential(credential);
  final User? user = userCredential.user;

  if (!isUnique) {
    // Show dialog to confirm if the user wants to merge existing data
    bool shouldMerge = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Phone Number Registered'),
          content: const Text(
              'This phone number is already registered. Would you like to merge your Google account with the existing data?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false); // Return false if cancelled
              },
            ),
            TextButton(
              child: const Text('Merge'),
              onPressed: () {
                Navigator.of(context).pop(true); // Return true if user wants to merge
              },
            ),
          ],
        );
      },
    ) ?? false; // Default to false if the dialog is dismissed

    if (!shouldMerge) {
      // If the user doesn't want to merge, exit or handle accordingly
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account merge cancelled.')),
      );
      return;
    }
  }

  if (user != null) {
    // Extract first name and last name from Google Display Name
    String? googleDisplayName = user.displayName;
    String? firstName;
    String? lastName;

    if (googleDisplayName != null) {
      List<String> nameParts = googleDisplayName.split(' ');
      firstName = nameParts.first;
      lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
    }

    // Check if the user already exists in Firestore
    final existingUser = await FirebaseFirestore.instance
        .collection('users')
        .where('phoneNumber', isEqualTo: widget.phoneNumber)
        .get();

    if (existingUser.docs.isNotEmpty) {
      // User already exists, update the document with Google account details
      final userDocId = existingUser.docs.first.id;
      await FirebaseFirestore.instance.collection('users').doc(userDocId).update({
        'email': user.email,
        'googleUid': user.uid,
        'googleDisplayName': googleDisplayName,
      });
    } else {
        String password = await _showCreatePasswordDialog();
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        if (password.isNotEmpty) {
          await FirebaseFirestore.instance.collection('users').add({
            'firstName': firstName,
            'lastName': lastName,
            'name': googleDisplayName,
            'phoneNumber': widget.phoneNumber,
            'password': hashedPassword,
            'createdAt': Timestamp.now(),
            'email': user.email,
            'googleUid': user.uid,
            'googleDisplayName': googleDisplayName,
              'completeNumber': widget.phoneCNumber,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User created successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password creation cancelled.')),
          );
        }
    }

    // Store a flag in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRegistered', true);
    
    // Navigate to the home screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Home(phoneNumber: widget.phoneNumber)),
      (Route<dynamic> route) => false,
    );
  }
} catch (e) {
  print('Error signing up with Google: $e');
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Failed to sign up with Google. Please try again.')),
  );
}
}

    Future<void> _submitData() async {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final name = '$firstName $lastName';
    final password = _passwordController.text;

    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
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
        'password': hashedPassword,
        'phoneNumber': widget.phoneNumber,
        'completeNumber': widget.phoneCNumber,
        'createdAt': Timestamp.now(), // Optional: Store the time of creation
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isRegistered', true);
      Navigator.push(

        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            phoneNumber: widget.phoneNumber,
          ),
        ),
      );
    } catch (e) {
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
              const SizedBox(height: 20),
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
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _signUpWithGoogle,
                    child: Image.asset(
                      'assets/google_icon.png',
                      height: 60,
                      width: 60,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Currently not available'),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/facebook_icon.png',
                      height: 60,
                      width: 60,
                    ),
                  ),
                ],
              ),
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
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Form(
                key:_formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$');
                          if (!regex.hasMatch(value)) {
                            return 'Password must be at least 8 characters, include an uppercase letter, a lowercase letter, and a number.';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),//Padding

              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Password meets all criteria
                    _submitData();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Account Creation')),
                    );
                  } else {
                    // If the form is not valid, show a message to the user
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill in the required fields')),
                    );
                  }
                },
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
