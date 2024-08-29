import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chungdam/screens/cart_provider.dart';
import 'package:chungdam/screens/cart_page.dart';


class MyeongphumPage extends StatefulWidget {
  final int index;

  MyeongphumPage(this.index);

  @override
  _MyeongphumPageState createState() => _MyeongphumPageState();
}

class _MyeongphumPageState extends State<MyeongphumPage> {
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
              // Navigate to cart page or show cart details
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Adjust content to start of column
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildImageWithButton(
                    'assets/hanwoo/myeongphumseta.png',
                    'assets/hanwoo/back.png',
                    isFront,
                    _toggleFirstImage,
                  ),
                  SizedBox(height: 30),
                  _buildOutlinedText('1++ ALA CARTE'),
                  SizedBox(height: 25),
                  buildGridView(context, [
                    'shortribs.png',
                    'skirtmeat.png',
                    'topblade.png',
                    'sirloin.png',
                    'ribeye.png',
                    'ribfinger.png',
                    'outsideskirtmeat.png',
                    'tenderloin.png',
                  ]),
                  SizedBox(height: 50),
                  _buildOutlinedText('PREMIUM ALA CARTE'),
                  SizedBox(height: 25),
                  buildGridView(context, [
                    'ribeyep.png',
                    'skirtmeatp.png',
                    'hangingtopblade.png',
                    'hangingsirloin.png',
                    'hangingtender.png',
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutlinedText(String text) {
    return Stack(
      children: [
        // Outline text
        Text(
          text,
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
          text,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0c2344), // Fill color
          ),
        ),
      ],
    );
  }

  Widget _buildImageWithButton(String imagePathFront, String imagePathBack, bool isFront, VoidCallback toggleImage) {
    return Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        GestureDetector(
          onTap: toggleImage,
          child: Container(
            margin: EdgeInsets.all(2), // Reduced margin for spacing
            child: ClipRRect( // Clip it with borderRadius if needed
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                isFront ? imagePathFront : imagePathBack,
                width: 330,
                height: 250,
              ),
            ),
          ),
        ),
        Positioned(
          top: 10, // Adjust this value to control the vertical positioning of the button
          left: -12, // Adjust this value to control the horizontal positioning of the button
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
              // Use CartProvider to add item to the cart
              Provider.of<CartProvider>(context, listen: false).addItem('myeongphumseta.png');
              print('Add to cart');
            },
          ),
        ),
      ],
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
            child: Image.asset('assets/hanwoo/$imageName', fit: BoxFit.cover),
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
              // Use CartProvider to add item to the cart
              Provider.of<CartProvider>(context, listen: false).addItem(imageName);
              print('Add $imageName to cart');
            },
          ),
        ),
      ],
    );
  }
}



  class MyeongphumBGCPage extends StatefulWidget {
    final int index;

    MyeongphumBGCPage(this.index);

    @override
    _MyeongphumBGCPageState createState() => _MyeongphumBGCPageState();
  }

  class _MyeongphumBGCPageState extends State<MyeongphumBGCPage> {
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
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start, // Adjust content to start of column
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildImageWithButton(
                      'assets/hanwoo/myeongphumseta.png',
                      'assets/hanwoo/back.png',
                      isFront,
                      _toggleFirstImage,
                    ),
                    SizedBox(height: 30),
                    _buildOutlinedText('1++ ALA CARTE'),
                    SizedBox(height: 25),
                    buildGridView(context, [
                      'shortribsb.png',
                      'skirtmeat.png',
                      'topbladeb.png',
                      'sirloin.png',
                      'ribeye.png',
                      'ribfingerb.png',
                      'outsideskirtmeatb.png',
                      'tenderloin.png',
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildOutlinedText(String text) {
      return Stack(
        children: [
          // Outline text
          Text(
            text,
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
            text,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0c2344), // Fill color
            ),
          ),
        ],
      );
    }

    Widget _buildImageWithButton(String imagePathFront, String imagePathBack, bool isFront, VoidCallback toggleImage) {
      return Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          GestureDetector(
            onTap: toggleImage,
            child: Container(
              margin: EdgeInsets.all(2), // Reduced margin for spacing
              child: ClipRRect( // Clip it with borderRadius if needed
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  isFront ? imagePathFront : imagePathBack,
                  width: 330,
                  height: 250,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10, // Adjust this value to control the vertical positioning of the button
            left: -12, // Adjust this value to control the horizontal positioning of the button
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
                print('Add to cart');
              },
            ),
          ),
        ],
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
              child: Image.asset('assets/hanwoo/$imageName', fit: BoxFit.cover),
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


  class MyeongphumMalatePage extends StatefulWidget {
    final int index;

    MyeongphumMalatePage(this.index);

    @override
    _MyeongphumMalatePageState createState() => _MyeongphumMalatePageState();
  }

  class _MyeongphumMalatePageState extends State<MyeongphumMalatePage> {
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
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start, // Adjust content to start of column
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildImageWithButton(
                      'assets/hanwoo/myeongphumsetamalate.png',
                      'assets/hanwoo/back.png',
                      isFront,
                      _toggleFirstImage,
                    ),
                    SizedBox(height: 30),
                    _buildOutlinedText('1++ ALA CARTE'),
                    SizedBox(height: 25),
                    buildGridView(context, [
                      'shortribsb.png',
                      'skirtmeat.png',
                      'topbladeb.png',
                      'sirloin.png',
                      'ribeye.png',
                      'ribfingerb.png',
                      'outsideskirtmeatb.png',
                      'tenderloin.png',
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildOutlinedText(String text) {
      return Stack(
        children: [
          // Outline text
          Text(
            text,
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
            text,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0c2344), // Fill color
            ),
          ),
        ],
      );
    }

    Widget _buildImageWithButton(String imagePathFront, String imagePathBack, bool isFront, VoidCallback toggleImage) {
      return Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          GestureDetector(
            onTap: toggleImage,
            child: Container(
              margin: EdgeInsets.all(2), // Reduced margin for spacing
              child: ClipRRect( // Clip it with borderRadius if needed
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  isFront ? imagePathFront : imagePathBack,
                  width: 330,
                  height: 250,
                ),
              ),
            ),
          ),
          Positioned(
            top: 10, // Adjust this value to control the vertical positioning of the button
            left: -12, // Adjust this value to control the horizontal positioning of the button
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
                print('Add to cart');
              },
            ),
          ),
        ],
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
              child: Image.asset('assets/hanwoo/$imageName', fit: BoxFit.cover),
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