import 'package:flutter/material.dart';

class WagyuSetPage extends StatefulWidget {
  final int index;

  WagyuSetPage(this.index);

  @override
  _WagyuSetPageState createState() => _WagyuSetPageState();
}

class _WagyuSetPageState extends State<WagyuSetPage> {
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
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Adjust content to start of column
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildImageWithButton(
                    'assets/wagyu/wagyuset.png',
                    'assets/wagyu/back.png',
                    isFront,
                    _toggleFirstImage,
                  ),
                  SizedBox(height: 30),
                  _buildOutlinedText('WAGYU ALA CARTE'),
                  SizedBox(height: 25),
                  buildGridView(context, [
                    'shortribs.png',
                    'skirtmeat.png',
                    'topblade.png',
                    'insideskirt.png',
                    'chuckeyeroll.png',
                    'brisket.png',
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
            child: Image.asset('assets/wagyu/$imageName', fit: BoxFit.cover),
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



class WagyuSetBGCPage extends StatefulWidget {
  final int index;

  WagyuSetBGCPage(this.index);

  @override
  _WagyuSetBGCPageState createState() => _WagyuSetBGCPageState();
}

class _WagyuSetBGCPageState extends State<WagyuSetBGCPage> {
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
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Adjust content to start of column
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: _buildImageWithButton(
                      'assets/wagyu/wagyuset.png',
                      'assets/wagyu/back.png',
                      isFront,
                      _toggleFirstImage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
            child: Image.asset('assets/wagyu/$imageName', fit: BoxFit.cover),
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


class WagyuSetMalatePage extends StatefulWidget {
  final int index;

  WagyuSetMalatePage(this.index);

  @override
  _WagyuSetMalatePageState createState() => _WagyuSetMalatePageState();
}

class _WagyuSetMalatePageState extends State<WagyuSetMalatePage> {
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
              padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Adjust content to start of column
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildImageWithButton(
                    'assets/wagyu/wagyuset.png',
                    'assets/wagyu/back.png',
                    isFront,
                    _toggleFirstImage,
                  ),
                  SizedBox(height: 30),
                  _buildOutlinedText('WAGYU ALA CARTE'),
                  SizedBox(height: 25),
                  buildGridView(context, [
                    'shortribs.png',
                    'skirtmeat.png',
                    'topblade.png',
                    'insideskirt.png',
                    'chuckeyeroll.png',
                    'brisket.png',
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
            child: Image.asset('assets/wagyu/$imageName', fit: BoxFit.cover),
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
