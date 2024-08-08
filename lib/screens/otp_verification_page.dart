import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OTPVerificationPage extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  final String phoneCNumber;

  const OTPVerificationPage({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
    required this.phoneCNumber,
  });

  @override
  // ignore: library_private_types_in_public_api
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  String pin = ''; 

  Future<void> _verifyOTP() async {
    final otp = pin;
    print(otp);
    final credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otp,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => SignUpScreen(
            phoneCNumber: widget.phoneCNumber,
            phoneNumber: widget.phoneNumber,
          ),
        ),
      );
    } catch (e) {
  // Show an error message to the user using a Snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('An error occurred: $e'),
      backgroundColor: Colors.red, // Optional: Set the background color
      duration: Duration(seconds: 3), // Optional: Set how long the Snackbar should be visible
    ),
  );
}
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/background.png'), // Ensure correct path and format
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Center the logo with padding adjustments
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 90.h), // Adjust top padding
              child: Image.asset(
                'assets/logo.png', // Ensure correct path
                height: 250.h,
                width: 250.w, // Adjusted size for the logo
              ),
            ),
          ),
          // Positioned OTP Verification Card at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxHeight: 1000.h, // Increased maximum height
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF112244), // Dark blue card color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60.0.r),
                  topRight: Radius.circular(60.0.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(30.0.w), // Adjusted for ScreenUtil
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10.h), // Added space above the text
                    Text(
                      'OTP Verification',
                      style: TextStyle(
                        fontSize: 30.sp, // Adjusted for ScreenUtil
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Enter OTP sent to ${widget.phoneNumber}',
                      style: TextStyle(
                        fontSize: 18.sp, // Adjusted for ScreenUtil
                        color: const Color(0xFFFAF7E8),
                      ),
                    ),
                    SizedBox(height: 50.h), // Added SizedBox below Enter OTP
                    // OTP Input Fields
                    OtpTextField(
                      numberOfFields: 6,
                      borderColor: const Color(0xFFFFD700),
                      focusedBorderColor: const Color(0xFFFFD700),
                      showFieldAsBox: false,
                      borderWidth: 2.0,
                      cursorColor:Color(0xFFFFD700),
                      textStyle:TextStyle(
                                fontSize: 24.sp, // Adjusted for ScreenUtil
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Ensures text is visible
                              ),
                      //runs when a code is typed in                     //runs when every textfield is filled 
                      onSubmit: (String verificationCode) {
                        setState(() {
                          pin = verificationCode; 
                          });// Store the full OTP
                      },   
                    ),
                    TextButton(
                      onPressed: () {
                        // Resend OTP Logic
                      },
                      child: Text(
                        'Resend Code',
                        style: TextStyle(
                          fontSize: 16.sp, // Adjusted for ScreenUtil
                          color: const Color(0xFFB2A2A2),
                        ),
                      ),
                    ),
                    SizedBox(height: 70.h), // Added SizedBox below Resend Code
                    SizedBox(
                      width: 200.w, // Reduced width
                      child: ElevatedButton(
                        onPressed: _verifyOTP,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFFFFD700), // Gold color for button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0.r), // Adjusted for ScreenUtil
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0.h), // Adjusted for ScreenUtil
                        ),
                        child: Text(
                          'GET STARTED',
                          style: TextStyle(
                            fontSize: 16.sp, // Adjusted for ScreenUtil
                            fontWeight: FontWeight.bold,
                            color: Colors.black, // Black text on gold button
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 100.h), // Added SizedBox below the button
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
