import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup.dart';

class OTPVerificationPage extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  final String phoneCNumber;

  const OTPVerificationPage({super.key, required this.verificationId, required this.phoneNumber, required this.phoneCNumber});

  @override
  // ignore: library_private_types_in_public_api
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  final FocusNode _focusNode = FocusNode();

  Future<void> _verifyOTP() async {
    final otp = _otpControllers.map((controller) => controller.text).join();
    final credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otp,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (kDebugMode) {
        print('Successfully Registered');
      }
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => SignUpScreen(phoneCNumber:widget.phoneCNumber, phoneNumber: widget.phoneNumber)),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Failed Register, please check your OTP');
      }
      // Show an error message to the user
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // Handle focus change if needed
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Column(
              children: [
                // Logo and Title
                Padding(
                  padding: EdgeInsets.only(top: 100.0.h), // Adjust top padding for positioning with ScreenUtil
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/logo.png', // Ensure correct path
                        height: 190.h, // Adjusted for ScreenUtil
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.h), // Adjusted for ScreenUtil
                // OTP Verification Card
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w), // Adjusted for ScreenUtil
                  child: Card(
                    color: const Color(0xFF112244), // Dark blue card color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0.r), // Adjusted for ScreenUtil
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: EdgeInsets.all(30.0.w), // Adjusted for ScreenUtil
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'OTP Verification',
                            style: TextStyle(
                              fontSize: 24.sp, // Adjusted for ScreenUtil
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20.h), // Adjusted for ScreenUtil
                          Text(
                            'Enter OTP sent to ${widget.phoneNumber}',
                            style: TextStyle(
                              fontSize: 16.sp, // Adjusted for ScreenUtil
                              color: const Color(0xFFFAF7E8),
                            ),
                          ),
                          SizedBox(height: 20.h), // Adjusted for ScreenUtil
                          // OTP Input Fields
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(6, (index) {
                              return SizedBox(
                                width: 50.w, // Adjusted for ScreenUtil
                                child: TextField(
                                  controller: _otpControllers[index],
                                  focusNode: index == 0 ? _focusNode : null,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    filled: true,
                                    fillColor: const Color(0xFFFAF7E8),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(3.0.r), // Adjusted for ScreenUtil
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 24.sp, // Adjusted for ScreenUtil
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  onChanged: (value) {
                                    if (value.length == 1 && index < 5) {
                                      FocusScope.of(context).nextFocus();
                                    } else if (value.isEmpty && index > 0) {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  },
                                ),
                              );
                            }),
                          ),
                          SizedBox(height: 20.h), // Adjusted for ScreenUtil
                          TextButton(
                            onPressed: () {
                              // Resend OTP Logic
                            },
                            child: Text(
                              'Resend Code',
                              style: TextStyle(
                                fontSize: 14.sp, // Adjusted for ScreenUtil
                                color: const Color(0xFFB2A2A2),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h), // Adjusted for ScreenUtil
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _verifyOTP,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFD700), // Yellow button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0.r), // Adjusted for ScreenUtil
                                ),
                                padding: EdgeInsets.symmetric(vertical: 20.0.h), // Adjusted for ScreenUtil
                              ),
                              child: Text(
                                'GET STARTED',
                                style: TextStyle(
                                  fontSize: 16.sp, // Adjusted for ScreenUtil
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
