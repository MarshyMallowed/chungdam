import 'package:flutter/material.dart';

class UpdateAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0c2344), // Set the AppBar background color
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView( // Make the page scrollable
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'How do I update my account information?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0), // Wider horizontal padding for this specific text
                child: Text(
                  'For changes to your phone number or other information tied to your account, please go to the "Personal Details" section of our app.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 10), // Minimal spacing before the first image
              Image.asset('assets/updateacc1.png', // Your first image
                fit: BoxFit.cover, // Cover the available space
              ),
              SizedBox(height: 5), // Very minimal spacing between the images to make them closer
              Image.asset('assets/updateacc2.png', // Your second image
                fit: BoxFit.cover, // Cover the available space
              ),
              SizedBox(height: 30), // Spacing after the second image
            ],
          ),
        ),
      ),
    );
  }
}
