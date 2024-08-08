import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: PaymentMethodPage()));
}

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  String paymentMethod = 'Card';
  String billingAddress = 'Same'; // To handle billing address radio selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Method"),
        backgroundColor: Color(0xFF0c2344),
        iconTheme: IconThemeData(color: Colors.white), // Set the icon color to white
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20), // Set the title color to white without bold
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 16.0),
              child: Text(
                "All transactions are secure",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            ),
            Card(
              color: Color(0xFF0c2344),
              margin: EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Radio(
                      value: 'Card',
                      groupValue: paymentMethod,
                      onChanged: (String? newValue) {
                        setState(() {
                          paymentMethod = newValue!;
                        });
                      },
                      activeColor: Color(0xFFD4AF37),
                      fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        return states.contains(MaterialState.selected) ? Color(0xFFD4AF37) : Colors.white;
                      }),
                    ),
                    title: Text('Card', style: TextStyle(color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 48.0),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.asset('assets/mastercard.png', width: 70),
                        ),
                        SizedBox(width: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.asset('assets/visa.png', width: 70),
                        ),
                        SizedBox(width: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.asset('assets/paypal.png', width: 70),
                        ),
                      ],
                    ),
                  ),
                  _buildPaymentOption('Cash on Delivery', null, null, null, titleOnly: 'Cash on Delivery'),
                  _buildPaymentOption('GCash', null, null, null, titleOnly: 'GCash'),
                  _buildPaymentOption('PayMaya', null, null, null, titleOnly: 'PayMaya'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 8.0),
              child: Text(
                "Billing Addresses",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 12.0),
              child: Text(
                "Select the address that matches your card or payment method",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
            ),
            _buildBillingOption('Same', 'Same as Shipping Address'),
            _buildBillingOption('Different', 'Use Different Billing Address'),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Pay Now'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(250, 40),
                    backgroundColor: Color(0xFF0c2344),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String value, String? asset1, String? asset2, String? asset3, {String? titleOnly}) {
    return ListTile(
      leading: Radio(
        value: value,
        groupValue: paymentMethod,
        onChanged: (String? newValue) {
          setState(() {
            paymentMethod = newValue!;
          });
        },
        activeColor: Color(0xFFD4AF37),
        fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          return states.contains(MaterialState.selected) ? Color(0xFFD4AF37) : Colors.white;
        }),
      ),
      title: titleOnly != null ? Text(titleOnly, style: TextStyle(color: Colors.white)) : Row(),
    );
  }

  Widget _buildBillingOption(String value, String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0), // Reduced vertical margin
      decoration: BoxDecoration(
        color: Color(0xFFFAF7E8),
        border: Border.all(color: Colors.black, width: 2.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Text(text, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: Radio(
          value: value,
          groupValue: billingAddress,
          onChanged: (String? newValue) {
            setState(() {
              billingAddress = newValue!;
            });
          },
          activeColor: Color(0xFF0c2344),
          fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
            return states.contains(MaterialState.selected) ? Color(0xFF0c2344) : Colors.black;
          }),
        ),
      ),
    );
  }
}
