import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup.dart';

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
  final List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
  List.generate(6, (_) => FocusNode());

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
        MaterialPageRoute(
          builder: (context) => SignUpScreen(
            phoneCNumber: widget.phoneCNumber,
            phoneNumber: widget.phoneNumber,
          ),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Failed Register, please check your OTP');
      }
      // Show an error message to the user
    }
  }

  @override
  void dispose() {
    _otpControllers.forEach((controller) => controller.dispose());
    _focusNodes.forEach((node) => node.dispose());
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: TextField(
                              controller: _otpControllers[index],
                              focusNode: _focusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              decoration: InputDecoration(
                                counterText: '',
                                filled: true,
                                fillColor: const Color(
                                    0xFF112244), // Match background color for underlines
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xFFFAF7E8),
                                      width: 2.0), // Underline color and thickness
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(
                                          0xFFFFD700), // Focused underline color
                                      width: 2.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 10.w),
                              ),
                              style: TextStyle(
                                fontSize: 24.sp, // Adjusted for ScreenUtil
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Ensures text is visible
                              ),
                              onChanged: (value) {
                                if (value.length == 1 && index < 5) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              onSubmitted: (_) {
                                if (_otpControllers[index].text.isEmpty &&
                                    index > 0) {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                              onEditingComplete: () {
                                if (_otpControllers[index].text.isEmpty &&
                                    index > 0) {
                                  FocusScope.of(context).previousFocus();
                                }
                              },
                            ),
                          ),
                        );
                      }),
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
