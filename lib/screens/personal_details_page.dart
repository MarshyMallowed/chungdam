

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalDetailsPage extends StatefulWidget {
  final String phoneNumber;
  const PersonalDetailsPage({super.key, required this.phoneNumber});
  
  @override
  _PersonalDetailsPageState createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  String _dateOfBirth = '2002-10-10';
  bool isGoogleConnected = false;
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  String? _lastName;
  String? _firstName;
  @override
  void initState() {
    super.initState();
    _fetchUserData();
    checkGoogleConnection();
  }
   Future<void> checkGoogleConnection() async {
  String phoneNumber = widget.phoneNumber;
  try {
    // Query the user's document(s) from Firestore where phoneNumber matches
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    // Check if the query returned any documents and if 'googleUid' exists
    if (querySnapshot.docs.isNotEmpty && querySnapshot.docs.first['googleUid'] != null) {
      setState(() {
        isGoogleConnected = true;
      });
    } else {
      setState(() {
        isGoogleConnected = false;
      });
    }
  } catch (e) {
    print('Error checking Google connection: $e');
    setState(() {
      isGoogleConnected = false;
    });
  }
}


  Future<void> _fetchUserData() async {
    String phoneNumber = widget.phoneNumber;

    try {
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();
      
      print('Number of documents found: ${userQuery.docs.length}'); // Debug: Check how many documents are found

      if (userQuery.docs.isNotEmpty) {
        DocumentSnapshot userDoc = userQuery.docs.first;
        setState(() {
          _emailController.text = userDoc.get('email') ?? 'No email';
          _addressController.text = userDoc.get('address') ?? 'No address';
          _firstName= userDoc.get('firstName') ?? 'No First Name';
          _lastName = userDoc.get('lastName') ?? 'No last name';
          _mobileNumberController.text = userDoc.get('phoneNumber') ?? 'No phone number';
          _dateOfBirth = userDoc.get('dateOfBirth') ?? _dateOfBirth;
        });
      } else {
        print("No user document found with phone number: $phoneNumber");
      }
    } catch (error) {
      print("Failed to fetch user data: $error");
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _updateEmail() async {
    String phoneNumber = widget.phoneNumber;

    try {
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (userQuery.docs.isNotEmpty) {
        DocumentSnapshot userDoc = userQuery.docs.first;
        String userId = userDoc.id;

        await FirebaseFirestore.instance.collection('users').doc(userId).update({
          'email': _emailController.text,
        }).then((_) {
          _showSnackbar("Email updated successfully.");
        }).catchError((error) {
          _showSnackbar("Failed to update email: $error");
        });
      } else {
        _showSnackbar("No user document found with phone number: $phoneNumber");
      }
    } catch (error) {
      _showSnackbar("Failed to update email: $error");
    }
  }

  void _updateAddress() async {
    String phoneNumber = widget.phoneNumber;

    try {
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (userQuery.docs.isNotEmpty) {
        DocumentSnapshot userDoc = userQuery.docs.first;
        String userId = userDoc.id;

        await FirebaseFirestore.instance.collection('users').doc(userId).update({
          'address': _addressController.text,
        }).then((_) {
          _showSnackbar("Address updated successfully.");
        }).catchError((error) {
          _showSnackbar("Failed to update address: $error");
        });
      } else {
        _showSnackbar("No user document found with phone number: $phoneNumber");
      }
    } catch (error) {
      _showSnackbar("Failed to update address: $error");
    }
  }

  void _updateDateOfBirth() async {
    String phoneNumber = widget.phoneNumber;

    try {
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (userQuery.docs.isNotEmpty) {
        DocumentSnapshot userDoc = userQuery.docs.first;
        String userId = userDoc.id;

        await FirebaseFirestore.instance.collection('users').doc(userId).update({
          'dateOfBirth': _dateOfBirth,
        }).then((_) {
          _showSnackbar("Date of birth updated successfully.");
        }).catchError((error) {
          _showSnackbar("Failed to update date of birth: $error");
        });
      } else {
        _showSnackbar("No user document found with phone number: $phoneNumber");
      }
    } catch (error) {
      _showSnackbar("Failed to update date of birth: $error");
    }
  }

  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateOfBirth = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
      _updateDateOfBirth(); // Update the date of birth in Firestore
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Details', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0c2344), // Dark blue color for AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            const Text(
              'First Name',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(_firstName ?? 'Loading...', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16.0),
            const Text(
              'Last Name',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(_lastName ?? 'Loading...', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16.0),
            const Text(
              'Mobile number',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.phoneNumber,
                    style: const TextStyle(fontSize: 18,),
                 ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Address',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: _updateAddress,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Email',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: _updateEmail,
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            
            const Text(
              'Date of birth',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Row(
              children: [
                Text(_dateOfBirth, style: const TextStyle(fontSize: 18)),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _selectDate,
                ),
              ],
            ),
            // Other widgets
            const SizedBox(height: 16.0),
            const Text('Connected Accounts', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16.0),
            //Row(
          //children: [
           // Image.asset('assets/facebook_icon.png', width: 40, height: 40),
           // const SizedBox(width: 16.0),
           // const Text('Facebook', style: TextStyle(fontSize: 18)),
           // const Spacer(),
            //const Text('Connected', style: TextStyle(fontSize: 16, color: Colors.blue)),
          //],
        //),
      //  const SizedBox(height: 16.0),
        Row(
          children: [
            Image.asset('assets/google_icon.png', width: 40, height: 40),
            const SizedBox(width: 16.0),
            const Text('Google', style: TextStyle(fontSize: 18)),
            const Spacer(),
            Text(
              isGoogleConnected ? 'Connected' : 'Not connected',
              style: TextStyle(
                fontSize: 16,
                color: isGoogleConnected ? Colors.blue : Colors.red,
              ),
            ),
          ],
        ),
            const SizedBox(height: 50),
            Center(
              child: TextButton(
                onPressed: () {
                  // Logic for deleting account
                },
                child: const Text(
                  'Delete my account',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
