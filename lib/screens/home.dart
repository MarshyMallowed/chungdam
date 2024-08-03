import 'package:flutter/material.dart';
import 'home_page.dart';
import 'personal_details_page.dart';
import 'vouchers_page.dart';
import 'payment_method_page.dart';
import 'language_page.dart';
import 'help_center_page.dart';




class Home extends StatelessWidget {
  final String firstName;
  final String phoneNumber;

  const Home({super.key, required this.firstName, required this.phoneNumber});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(firstName: firstName, phoneNumber: phoneNumber,),
      routes: {
        '/home': (context) => HomePage(firstName: firstName,
                phoneNumber: phoneNumber,),
        '/personal_details': (context) => const PersonalDetailsPage(),
        '/vouchers': (context) => const VouchersPage(),
        '/payment_method': (context) => const PaymentMethodPage(),
        '/language': (context) => const LanguagePage(),
        '/help_center': (context) => const HelpCenterPage(),
      },
    );
  }
}
