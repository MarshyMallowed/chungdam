import 'package:flutter/material.dart';

class SpecialMenuMeatPage extends StatefulWidget {
  final int index;

  SpecialMenuMeatPage(this.index);

  @override
  _SpecialMenuMeatPageState createState() => _SpecialMenuMeatPageState();
}

class _SpecialMenuMeatPageState extends State<SpecialMenuMeatPage> {
  bool isFront = true; // Tracks whether the front image is displayed

  void _toggleFirstImage() {
    setState(() {
      isFront = !isFront; // Toggles the image display state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5, // Adjust opacity as needed
            child: Image.asset(
              'assets/others/background2.png', // Background image path
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SingleChildScrollView( // Wrap content in SingleChildScrollView for scrolling
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Adjust content to start of column
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  buildGridView(context, [
                    'beefabomasum.png',
                    'porkabomasum.png',
                    'beefheart.png',
                    'beefintestine.png',
                    'beefribs.png',
                    'lagalbi.png',
                    'porkribs.png',
                    'gopchangset.png',
                    'yukhwe.png',
                    'galbihotpot.png',
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridView(BuildContext context, List<String> imageNames) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: (1 / 1.2),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: imageNames.map((imageName) => buildImageCard(context, imageName)).toList(),
    );
  }

  Widget buildImageCard(BuildContext context, String imageName) {
    return Stack(
      alignment: Alignment.topLeft,
      clipBehavior: Clip.none, // Allows the button to be positioned out of the box
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('assets/specialmenumeat/$imageName', fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: -22, // Adjust this value to control the vertical positioning of the button
          left: -18, // Adjust this value to control the horizontal positioning of the button
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Color(0xFF0C2344), // Button background color
              foregroundColor: Color(0xFFFAF7E8), // Icon color
              padding: EdgeInsets.zero,
              minimumSize: Size(25, 25), // Adjusts the size of the button
            ),
            child: Icon(Icons.add, size: 16),
            onPressed: () {
              print('Add $imageName to cart');
            },
          ),
        ),
      ],
    );
  }
}


class SpecialMenuMeatBGCPage extends StatefulWidget {
  final int index;

  SpecialMenuMeatBGCPage(this.index);

  @override
  _SpecialMenuMeatBGCPageState createState() => _SpecialMenuMeatBGCPageState();
}

class _SpecialMenuMeatBGCPageState extends State<SpecialMenuMeatBGCPage> {
  bool isFront = true; // Tracks whether the front image is displayed

  void _toggleFirstImage() {
    setState(() {
      isFront = !isFront; // Toggles the image display state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5, // Adjust opacity as needed
            child: Image.asset(
              'assets/others/background2.png', // Background image path
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SingleChildScrollView( // Wrap content in SingleChildScrollView for scrolling
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Adjust content to start of column
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  buildGridView(context, [
                    'beefabomasum.png',
                    'porkabomasum.png',
                    'beefintestine.png',
                    'lagalbi.png',
                    'yukhwe.png',
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridView(BuildContext context, List<String> imageNames) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: (1 / 1.2),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: imageNames.map((imageName) => buildImageCard(context, imageName)).toList(),
    );
  }

  Widget buildImageCard(BuildContext context, String imageName) {
    return Stack(
      alignment: Alignment.topLeft,
      clipBehavior: Clip.none, // Allows the button to be positioned out of the box
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('assets/specialmenumeat/$imageName', fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: -22, // Adjust this value to control the vertical positioning of the button
          left: -18, // Adjust this value to control the horizontal positioning of the button
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Color(0xFF0C2344), // Button background color
              foregroundColor: Color(0xFFFAF7E8), // Icon color
              padding: EdgeInsets.zero,
              minimumSize: Size(25, 25), // Adjusts the size of the button
            ),
            child: Icon(Icons.add, size: 16),
            onPressed: () {
              print('Add $imageName to cart');
            },
          ),
        ),
      ],
    );
  }
}


class SpecialMenuMeatMalatePage extends StatefulWidget {
  final int index;

  SpecialMenuMeatMalatePage(this.index);

  @override
  _SpecialMenuMeatMalatePageState createState() => _SpecialMenuMeatMalatePageState();
}

class _SpecialMenuMeatMalatePageState extends State<SpecialMenuMeatMalatePage> {
  bool isFront = true; // Tracks whether the front image is displayed

  void _toggleFirstImage() {
    setState(() {
      isFront = !isFront; // Toggles the image display state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5, // Adjust opacity as needed
            child: Image.asset(
              'assets/others/background2.png', // Background image path
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SingleChildScrollView( // Wrap content in SingleChildScrollView for scrolling
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Adjust content to start of column
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  buildGridView(context, [
                    'beefabomasumm.png',
                    'porkabomasumm.png',
                    'beefheartm.png',
                    'beefintestinem.png',
                    'beefribs.png',
                    'lagalbim.png',
                    'porkribs.png',
                    'gopchangset.png',
                    'yukhwe.png',
                    'galbihotpotm.png',
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridView(BuildContext context, List<String> imageNames) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: (1 / 1.2),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: imageNames.map((imageName) => buildImageCard(context, imageName)).toList(),
    );
  }

  Widget buildImageCard(BuildContext context, String imageName) {
    return Stack(
      alignment: Alignment.topLeft,
      clipBehavior: Clip.none, // Allows the button to be positioned out of the box
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('assets/specialmenumeat/$imageName', fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: -22, // Adjust this value to control the vertical positioning of the button
          left: -18, // Adjust this value to control the horizontal positioning of the button
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Color(0xFF0C2344), // Button background color
              foregroundColor: Color(0xFFFAF7E8), // Icon color
              padding: EdgeInsets.zero,
              minimumSize: Size(25, 25), // Adjusts the size of the button
            ),
            child: Icon(Icons.add, size: 16),
            onPressed: () {
              print('Add $imageName to cart');
            },
          ),
        ),
      ],
    );
  }
}
