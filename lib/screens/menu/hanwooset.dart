import 'package:flutter/material.dart';

class HanwooSetPage extends StatefulWidget {
  final int index;
  HanwooSetPage(this.index);

  @override
  _HanwooSetPageState createState() => _HanwooSetPageState();
}

class _HanwooSetPageState extends State<HanwooSetPage> {
  bool isFront = true; // State to track which first image is displayed
  bool isSecondFront = true; // State to track which second image is displayed

  void _toggleFirstImage() {
    setState(() {
      isFront = !isFront; // Toggle the state to switch the first set of images
    });
  }

  void _toggleSecondImage() {
    setState(() {
      isSecondFront = !isSecondFront; // Toggle the state to switch the second set of images
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HANWOO SET',
          style: TextStyle(
            color: Color(0xFFFAF7E8), // Cream color for the text
            fontSize: 22,
          ),
        ),
        backgroundColor: Color(0xFF0C2344), // Dark blue color for the app bar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFAF7E8)), // Custom back button color
          onPressed: () => Navigator.of(context).pop(), // Navigate back
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Color(0xFFFAF7E8)), // Cream color for the cart icon
            onPressed: () {
              // Implement cart action here
              print('Shopping cart tapped');
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFFFAF7E8), // Cream color for the background of the Scaffold
      body: Padding(
        padding: const EdgeInsets.only(top: 30), // Adds padding at the top
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Adjust content to start of column
            children: [
              _buildImageWithButton('assets/hanwooset/seta.png', 'assets/hanwooset/back.png', isFront, _toggleFirstImage),
              SizedBox(height: 0), // Spacing between the two images
              _buildImageWithButton('assets/hanwooset/setb.png', 'assets/hanwooset/back.png', isSecondFront, _toggleSecondImage),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageWithButton(String imagePathFront, String imagePathBack, bool isFront, VoidCallback toggleImage) {
    return Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        GestureDetector(
          onTap: toggleImage,
          child: Container(
            margin: EdgeInsets.all(6), // Margin to allow shadow visibility
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03), // Shadow color with moderate opacity
                  spreadRadius: 0, // Controls the size of the shadow
                  blurRadius: 10, // Softens the shadow edges
                  offset: Offset(0, 15), // Offset to the right and downward
                ),
              ],
              borderRadius: BorderRadius.circular(8), // Optional: to add a rounded corner
            ),
            child: ClipRRect( // Clip it with borderRadius if needed
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                isFront ? imagePathFront : imagePathBack,
                width: 330,
                height: 250,
              ),
            ),
          ),
        ),
        Positioned(
          left: 1,
          top: 5,
          child: FloatingActionButton(
            onPressed: () {
              // Additional action for the button press
              print('Addition button tapped');
            },
            child: Icon(Icons.add, color: Color(0xFFFAF7E8)), // Icon color
            backgroundColor: Color(0xFF0C2344), // Button background color
            mini: true, // Use a smaller button
          ),
        ),
      ],
    );
  }
}
