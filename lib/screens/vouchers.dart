import 'package:flutter/material.dart';
import 'dart:async';

class VouchersPage extends StatefulWidget {
  const VouchersPage({Key? key}) : super(key: key);

  @override
  _VouchersPageState createState() => _VouchersPageState();
}

class _VouchersPageState extends State<VouchersPage> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // Set up a periodic timer to automatically scroll the vouchers
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        final nextPage = (_currentPage + 1) % 3;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // List of images for the grid, repeating the specified sequence
    final List<String> discountImages = [
      'assets/discount1.png',
      'assets/discount2.png',
      'assets/discount3.png',
      'assets/discount2.png',
      'assets/discount1.png',
      'assets/discount2.png',
      'assets/discount3.png',
      'assets/discount2.png', // Repeating pattern
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0c2344),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        title: const Text('Vouchers', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter voucher code',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                  suffixIcon: TextButton(
                    onPressed: () {},
                    child: const Text('Redeem Code', style: TextStyle(color: Colors.blue)),
                  ),
                ),
              ),
            ),
            Container(
              height: 200, // Height for the PageView
              child: PageView(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  Image.asset('assets/birthday_voucher.png', width: screenWidth, fit: BoxFit.cover),
                  Image.asset('assets/newyear_voucher.png', width: screenWidth, fit: BoxFit.cover),
                  Image.asset('assets/birthday_voucher.png', width: screenWidth, fit: BoxFit.cover),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6.0, 20.0, 6.0, 6.0), // Adjusted top padding to 20.0
              child: const Text(
                'Discover more deals',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // GridView for the first row of images
            Container(
              height: screenWidth / 3, // Height for a single row
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4, // First row with four images
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // Single row
                  childAspectRatio: 1, // Aspect ratio of 1 for square cells
                  mainAxisSpacing: 0, // No space between columns
                  crossAxisSpacing: 0, // No space between rows since it’s a single row
                ),
                itemBuilder: (context, index) {
                  return Image.asset(discountImages[index], fit: BoxFit.cover);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0), // Add some vertical padding
              child: const Text(
                'More deals',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // GridView for the second row of images
            Container(
              height: screenWidth / 3, // Height for a single row
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4, // Second row with four images
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, // Single row
                  childAspectRatio: 1, // Aspect ratio of 1 for square cells
                  mainAxisSpacing: 0, // No space between columns
                  crossAxisSpacing: 0, // No space between rows since it’s a single row
                ),
                itemBuilder: (context, index) {
                  return Image.asset(discountImages[index + 4], fit: BoxFit.cover);
                },
              ),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(100.0),
              ),
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/refer_friend.png', width: 70, height: 70),
                      const SizedBox(width: 20),
                      const Text('Refer friends and get ₱100.00'),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Details'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
