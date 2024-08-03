import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PersonalDetailsPageState createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  String _dateOfBirth = '2002-10';
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addressController.text = 'Street, District, Barangay, Postal Code, and City / Municipality';
    _emailController.text = 'Name@gmail.com';
    _mobileNumberController.text = '0912 345 6789';
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
            const Text('Name', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16.0),
            const Text(
              'Last Name',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Text('Name', style: TextStyle(fontSize: 18)),
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
                  onPressed: () {
                    // Logic to edit address
                  },
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
                  onPressed: () {
                    // Logic to edit email
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Mobile number',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _mobileNumberController,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // Logic to edit mobile number
                  },
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
            const SizedBox(height: 16.0),
            const Text('Connected Accounts', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Image.asset('assets/facebook_icon.png', width: 40, height: 40),
                const SizedBox(width: 16.0),
                const Text('Facebook', style: TextStyle(fontSize: 18)),
                const Spacer(),
                const Text('Connected', style: TextStyle(fontSize: 16, color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Image.asset('assets/google_icon.png', width: 40, height: 40),
                const SizedBox(width: 16.0),
                const Text('Google', style: TextStyle(fontSize: 18)),
                const Spacer(),
                const Text('Not connected', style: TextStyle(fontSize: 16, color: Colors.red)),
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
