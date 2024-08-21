import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Payment Methods', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0c2344),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),  // Adjustable padding
              child: Text(
                'What payment methods are accepted at Chung Dam?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),  // Horizontal margin for the container
              child: Text(
                'At Chung Dam, we strive to make your dining experience as convenient as possible. We accept the following:',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),
            Image.asset('assets/payment.png'),  // Image inclusion
          ],
        ),
      ),
    );
  }
}
