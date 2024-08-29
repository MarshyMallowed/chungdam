import 'package:flutter/material.dart';

class StewPage extends StatefulWidget {
  final int index;

  StewPage(this.index);

  @override
  _StewPageState createState() => _StewPageState();
}

class _StewPageState extends State<StewPage> {
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
                    'bulgogibeef1.png',
                    'bulgogibeef2.png',
                    'chadoldenjang.png',
                    'haemuldenjang.png',
                    'kimchi.png',
                    'odeng.png',
                    'femalecrab.png',
                  ]),
                  SizedBox(height: 50),
                  Stack(
                    children: [
                      // Outline text
                      Text(
                        'STEW MEAL',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 4
                            ..color = Color(0xFFFAF7E8), // Outline color
                        ),
                      ),
                      // Solid text
                      Text(
                        'STEW MEAL',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0c2344), // Fill color
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  buildGridView(context, [
                    'koreanbeefmeal.png',
                    'beefmiyeokmeal.png',
                    'chadoldenjangmeal.png',
                    'haemuldenjangmeal.png',
                    'kimchisoftbonemeal.png',
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
            child: Image.asset('assets/stew/$imageName', fit: BoxFit.cover),
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


class StewBGCPage extends StatefulWidget {
  final int index;

  StewBGCPage(this.index);

  @override
  _StewBGCPageState createState() => _StewBGCPageState();
}

class _StewBGCPageState extends State<StewBGCPage> {
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
                    'bulgogibeef1.png',
                    'bulgogibeef2.png',
                    'chadoldenjang.png',
                    'haemuldenjang.png',
                    'kimchi.png',
                    'odeng.png',
                    'femalecrab.png',
                  ]),
                  SizedBox(height: 50),
                  Stack(
                    children: [
                      // Outline text
                      Text(
                        'STEW MEAL',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 4
                            ..color = Color(0xFFFAF7E8), // Outline color
                        ),
                      ),
                      // Solid text
                      Text(
                        'STEW MEAL',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0c2344), // Fill color
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  buildGridView(context, [
                    'koreanbeefmeal.png',
                    'beefmiyeokmeal.png',
                    'chadoldenjangmeal.png',
                    'haemuldenjangmeal.png',
                    'kimchisoftbonemeal.png',
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
            child: Image.asset('assets/stew/$imageName', fit: BoxFit.cover),
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


class StewMalatePage extends StatefulWidget {
  final int index;

  StewMalatePage(this.index);

  @override
  _StewMalatePageState createState() => _StewMalatePageState();
}

class _StewMalatePageState extends State<StewMalatePage> {
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
                    'bulgogibeefm.png',
                    'chadoldenjangm.png',
                    'haemuldenjang.png',
                    'kimchi.png',
                    'odeng.png',
                    'femalecrabm.png',
                  ]),
                  SizedBox(height: 50),
                  Stack(
                    children: [
                      // Outline text
                      Text(
                        'STEW MEAL',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 4
                            ..color = Color(0xFFFAF7E8), // Outline color
                        ),
                      ),
                      // Solid text
                      Text(
                        'STEW MEAL',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0c2344), // Fill color
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  buildGridView(context, [
                    'koreanbeefmeal.png',
                    'beefmiyeokmealm.png',
                    'chadoldenjangmealm.png',
                    'haemuldenjangmealm.png',
                    'kimchisoftbonemealm.png',
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
            child: Image.asset('assets/stew/$imageName', fit: BoxFit.cover),
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


