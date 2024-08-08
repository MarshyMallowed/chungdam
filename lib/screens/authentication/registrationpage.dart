import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_verification_page.dart'; // Ensure you have this file

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String phoneNumber = '';
  String verificationId = '';
  String phoneCNumber = '';
  
  Future<void> _sendOTP() async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification (rarely happens)
          // You can directly sign in with the credential here if auto-verification is successful
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle errors, like invalid phone number format
          if (kDebugMode) {
            print('Verification failed: ${e.message}');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          // Store the verification ID for later use
          setState(() {
            this.verificationId = verificationId;
          });
          // Navigate to OTP Verification Page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPVerificationPage(
                verificationId: verificationId,
                phoneNumber: phoneNumber,
                phoneCNumber: phoneCNumber,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout if the user doesn't enter the OTP
          if (kDebugMode) {
            print('Code auto-retrieval timeout');
          }
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error sending OTP: ${e.toString()}');
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 912), // Base screen size for design
      minTextAdapt: true,
      builder: (context, child) {
        return Scaffold(
          resizeToAvoidBottomInset: true, // Allows the screen to adjust for the keyboard
          body: Stack(
            children: [
              // Background Image
              Container(
                height: 1000.h, // Adjusted for ScreenUtil
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.png'), // Ensure correct path and format
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Content
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom), // Adjust for keyboard
                  child: Column(
                    children: [
                      // Logo and Title
                      Padding(
                        padding: EdgeInsets.only(top: 100.0.h), // Adjust top padding for positioning with ScreenUtil
                        child: Image.asset(
                          'assets/logo.png', // Ensure correct path
                          height: 300.h, // Adjusted for ScreenUtil
                        ),
                      ),
                      SizedBox(height:70.0.h),// Expanded OTP Verification Card
                      Container(
                        height: MediaQuery.of(context).size.height - 470.0.h, // Adjust the height to fit remaining screen
                        decoration: BoxDecoration(
                          color: const Color(0xFF112244), // Dark blue card color
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50.0.r), // Adjusted for ScreenUtil
                            topRight: Radius.circular(50.0.r), // Adjusted for ScreenUtil
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(40.0.w), // Adjusted for ScreenUtil
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Registration',
                                style: TextStyle(
                                  fontSize: 39.sp, // Adjusted for ScreenUtil
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10.h), // Adjusted for ScreenUtil
                              Padding(
                                padding: EdgeInsets.all(2.h),
                                child: Text(
                                  'We will send you a one-time password to this mobile number',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.sp, // Adjusted for ScreenUtil
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h), // Adjusted for ScreenUtil
                              // OTP Input Fields
                              IntlPhoneField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0.w),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                initialCountryCode: 'PH',
                                onChanged: (phone) {
                                  phoneNumber = phone.completeNumber;
                                  phoneCNumber = '0${phone.number}';
                                  if (kDebugMode) {
                                    print(phone.completeNumber);
                                  }
                                },
                              ),
                              SizedBox(height: 20.h), // Adjusted for ScreenUtil
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _sendOTP,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFD700), // Yellow button color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0.r), // Adjusted for ScreenUtil
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 20.0.h), // Adjusted for ScreenUtil
                                  ),
                                  child: Text(
                                    'GET OTP',
                                    style: TextStyle(
                                      fontSize: 18.sp, // Adjusted for ScreenUtil
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black, // Black text on yellow button
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h), // Adjusted for ScreenUtil
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
