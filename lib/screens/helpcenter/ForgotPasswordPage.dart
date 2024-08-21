import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0c2344),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(  // Wrap the body with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'I forgot my password. How do I reset it?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Here's how you can reset your password and regain access to your account:",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "The easiest and fastest method is to use your phone or another trusted device, preferably one that you've previously used to access our app with your account ID. This allows us to confirm your identity.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(
                        text: "To reset your password,",
                        style: TextStyle(fontWeight: FontWeight.bold),  // Make this part bold
                      ),
                      TextSpan(
                          text: " click on 'Forgot password?' on the login page."
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Image.asset('assets/forgotpass.png'), // Adding the image here
            ],
          ),
        ),
      ),
    );
  }
}
