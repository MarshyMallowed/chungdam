import 'package:flutter/material.dart';

class SamgyeopsalPage extends StatefulWidget {
  final int index;

  SamgyeopsalPage(this.index);

  @override
  _SamgyeopsalPageState createState() => _SamgyeopsalPageState();
}

class _SamgyeopsalPageState extends State<SamgyeopsalPage> {

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
          // Background image
          Opacity(
            opacity: 0.5, // Adjust opacity as needed
            child: Image.asset(
              'assets/others/background2.png', // Background image path
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Main content
          SingleChildScrollView( // Wrap content in SingleChildScrollView for scrolling
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Adjust content to start of column
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  buildGridView(context, [
                    'ssamgyupsal.png',
                    'psamgyupsal.png',
                    'sporkneck.png',
                    'pporkneck.png',
                    'sporkjowl.png',
                    'pporkjowl.png',
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
            child: Image.asset('assets/samgyeopsal/$imageName', fit: BoxFit.cover),
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

class SamgyeopsalBGCPage extends StatefulWidget {
  final int index;

  SamgyeopsalBGCPage(this.index);

  @override
  _SamgyeopsalBGCPageState createState() => _SamgyeopsalBGCPageState();
}

class _SamgyeopsalBGCPageState extends State<SamgyeopsalBGCPage> {

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
          // Background image
          Opacity(
            opacity: 0.5, // Adjust opacity as needed
            child: Image.asset(
              'assets/others/background2.png', // Background image path
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Main content
          SingleChildScrollView( // Wrap content in SingleChildScrollView for scrolling
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Adjust content to start of column
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  buildGridView(context, [
                    'ssamgyupsal.png',
                    'psamgyupsal.png',
                    'sporkneck.png',
                    'pporkneck.png',
                    'sporkjowl.png',
                    'pporkjowl.png',
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
            child: Image.asset('assets/samgyeopsal/$imageName', fit: BoxFit.cover),
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


class SamgyeopsalMalatePage extends StatefulWidget {
  final int index;

  SamgyeopsalMalatePage(this.index);

  @override
  _SamgyeopsalMalatePageState createState() => _SamgyeopsalMalatePageState();
}

class _SamgyeopsalMalatePageState extends State<SamgyeopsalMalatePage> {

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
          // Background image
          Opacity(
            opacity: 0.5, // Adjust opacity as needed
            child: Image.asset(
              'assets/others/background2.png', // Background image path
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          // Main content
          SingleChildScrollView( // Wrap content in SingleChildScrollView for scrolling
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Adjust content to start of column
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  buildGridView(context, [
                    'ssamgyupsal.png',
                    'psamgyupsalm.png',
                    'sporkneck.png',
                    'pporkneckm.png',
                    'sporkjowl.png',
                    'pporkjowl.png',
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
            child: Image.asset('assets/samgyeopsal/$imageName', fit: BoxFit.cover),
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

