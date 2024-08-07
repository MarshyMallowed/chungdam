// lib/custom_widget.dart

import 'package:flutter/material.dart';

// Define your custom widget here
class StartPage extends StatelessWidget {
  final double marginValue;
  final double paddingValue;
  final Color containerBackgroundColor;
  final double borderRadiusValue;
  final Color borderColor;
  final Color thinBorderColor;

  const StartPage({
    Key? key,
    required this.marginValue,
    required this.paddingValue,
    required this.containerBackgroundColor,
    required this.borderRadiusValue,
    required this.borderColor,
    required this.thinBorderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            const Center(
              child: Column(
                children: [
                  Text(
                    'Welcome to',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'CHUNG DAM!',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD4AF37), // Gold color
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: marginValue, vertical: marginValue),
                  padding: EdgeInsets.all(paddingValue),
                  decoration: BoxDecoration(
                    color: containerBackgroundColor,
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    border: Border.all(color: borderColor, width: 3.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 1.0,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        const Color(0xFF0c2344).withOpacity(0.3),
                        BlendMode.srcATop,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: thinBorderColor, width: 1.0),
                                    image: const DecorationImage(
                                      image: AssetImage('assets/food4.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 250,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(color: thinBorderColor, width: 1.0),
                                        image: const DecorationImage(
                                          image: AssetImage('assets/food3.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 100,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(color: thinBorderColor, width: 1.0),
                                        image: const DecorationImage(
                                          image: AssetImage('assets/food2.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 145,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: thinBorderColor, width: 1.0),
                              image: const DecorationImage(
                                image: AssetImage('assets/food5.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            height: 100,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30.0,
                  right: 30.0,
                  child: ElevatedButton(
                    onPressed: () {
                      // Order Now Logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFfff6cd),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 5.0,
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'ORDER NOW!',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadiusValue),
                  child: Image.asset(
                    'assets/food5.jpg',
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
