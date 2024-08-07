import 'package:flutter/material.dart';
import 'home_page.dart';
import 'personal_details_page.dart';
import 'vouchers.dart';
import 'payment_method_page.dart';
import 'language_page.dart';
import 'help_center_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  final String firstName;
  final String phoneNumber;

  const Home({super.key, required this.firstName, required this.phoneNumber});
  @override
  HomeState createState() => HomeState();
}
class HomeState extends State<Home> {

  String? _firstName;
  String? _lastName;
  String? _address;
  String? _email;
  String? _dateOfBirth;
   @override
  void initState() {
    super.initState();
   _fetchUserData();
  }

Future<void> _fetchUserData() async {

    try {
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: widget.phoneNumber)
          .get();
      
      print('Number of documents found: ${userQuery.docs.length}'); // Debug: Check how many documents are found

      if (userQuery.docs.isNotEmpty) {
        DocumentSnapshot userData = userQuery.docs.first;
        setState(() {
        _firstName = userData['firstName'];
        _lastName = userData['lastName'];
        _address = userData['address'];
        _email = userData['email'];
        _dateOfBirth = userData['dateOfBirth'];
        });
      } else {
        print("No user document found with phone number: $widget.phoneNumber");
      }
    } catch (error) {
      print("Failed to fetch user data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Chung Dam',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(firstName: _firstName ?? 'No Name', phoneNumber: widget.phoneNumber,),
      routes: {
        '/home': (context) => HomePage(firstName: _firstName ?? 'No Name',
                phoneNumber: widget.phoneNumber,),
        '/personal_details': (context) => PersonalDetailsPage(phoneNumber:widget.phoneNumber,),
        '/vouchers': (context) => const VouchersPage(),
        '/payment_method': (context) => const PaymentMethodPage(),
        '/language': (context) => const LanguagePage(),
        '/help_center': (context) => const HelpCenterPage(),
      },
    );
  }
}
