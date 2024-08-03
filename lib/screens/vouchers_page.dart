import 'package:flutter/material.dart';
import 'dart:async';

class VouchersPage extends StatefulWidget {
  const VouchersPage({super.key});

  @override
  _VouchersPageState createState() => _VouchersPageState();
}

class _VouchersPageState extends State<VouchersPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        final currentScroll = _scrollController.offset;
        final maxScroll = _scrollController.position.maxScrollExtent;
        final screenWidth = MediaQuery.of(context).size.width;

        if (currentScroll >= maxScroll) {
          _scrollController.animateTo(0.0,
              duration: const Duration(seconds: 1), curve: Curves.easeInOut);
        } else {
          _scrollController.animateTo(currentScroll + screenWidth,
              duration: const Duration(seconds: 1), curve: Curves.easeInOut);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0c2344), // Adjust the color to match the screenshot
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Row(
                children: [
                  Image.asset('assets/birthday_voucher.png', width: screenWidth, fit: BoxFit.cover),
                  Image.asset('assets/newyear_voucher.png', width: screenWidth, fit: BoxFit.cover),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(6.0),
              child: Text(
                'Discover more deals',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(3, (index) {
                return Card(
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset('assets/discount${index + 1}.png', fit: BoxFit.cover),
                );
              }),
            ),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/refer_friend.png', width: 40, height: 40),
                      const SizedBox(width: 10),
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
