import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chungdam/screens/cart_provider.dart';
import 'package:chungdam/screens/cart_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chungdam/screens/menu/branch_provider.dart';
class MyeongphumPage extends StatefulWidget {
  final int index; // Assumes this is the branch or another identifier for filtering

  MyeongphumPage(this.index);

  @override
  _MyeongphumPageState createState() => _MyeongphumPageState();
}

class _MyeongphumPageState extends State<MyeongphumPage> {
  bool isFront = true; // Tracks whether the front image is displayed
  List<MenuItem> menuItems = []; // List to hold menu items fetched from Firestore
  @override
  void initState() {
    super.initState();
  }
  void _toggleFirstImage() {
    setState(() {
      isFront = !isFront; // Toggles the image display state
    });
  }

  @override
  Widget build(BuildContext context) {
  final branch = Provider.of<BranchProvider>(context).selectedBranch;
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
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
                  SizedBox(height: 30),
                  _buildButtonItems(branch),
                  _buildOutlinedText('1++ ALA CARTE'),
                  SizedBox(height: 25),
                  _buildGridView(branch),
                  SizedBox(height: 50),
                  _buildOutlinedText('PREMIUM ALA CARTE'),
                  SizedBox(height: 25),
                  _buildGridView1(branch), // Same grid for premium items, you might want to differentiate
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
  Widget _buildButtonItems(branch) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('items')
          .where('branch', isEqualTo: branch)
          .where('withButtons', isEqualTo:'true')
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Show a loading indicator
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No items found'));
        }

        // Wrap ListView with Container or SizedBox to constrain its height
        return Container(
          height: 220, // Set a specific height or use MediaQuery to make it responsive
          child: ListView(
            children: snapshot.data!.docs.map((doc) {
              // Extract data from the document
              final data = doc.data() as Map<String, dynamic>;
              final imagePathFront = data['imagePathFront'];
              final imagePathBack = data['imagePathBack'];
              final itemName = data['itemName'];
              final price = data['price'];
              final itemCartImage = data['itemCartImage'];
              final itemId = data['itemId'];
              final weight = data['weight'] as int;

              return _buildImageWithButton(
                imagePathFront,
                imagePathBack,
                true, // Assuming default isFront is true
                () {
                  _toggleFirstImage();
                },
                itemId,
                itemName,
                price,
                itemCartImage,
                weight,
                branch
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildImageWithButton(
  String imagePathFront,
  String imagePathBack,
  bool isFront,
  VoidCallback toggleImage,
  String itemId,
  String itemName,
  int price,
  String itemCartImage,
  int weight,
  String branch,
) {
  return Stack(
    alignment: Alignment.topLeft,
    clipBehavior: Clip.none, // Allows the button to be positioned out of the box
    children: [
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(8),
        ),
        child: GestureDetector(
          onTap: toggleImage,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              isFront ? imagePathFront : imagePathBack,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Positioned(
        top: -22, // Adjust this value to control the vertical positioning of the button
        left: -18, // Adjust this value to control the horizontal positioning of the button
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: Color(0xFF0C2344),
            foregroundColor: Color(0xFFFAF7E8),
            padding: EdgeInsets.zero,
            minimumSize: Size(25, 25), // Adjusts the size of the button
          ),
          child: Icon(Icons.add, size: 16),
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false).addToCart(
              branch,
              CartItemData(
                itemId: itemId,
                itemCartImage: itemCartImage,
                itemName: itemName,
                price: price,
                weight: weight,
              ),
            );
            print('Added to cart: $itemName');
          },
        ),
      ),
    ],
  );
}


Widget _buildGridView(String branch) {
  return FutureBuilder<QuerySnapshot>(
    future: FirebaseFirestore.instance
        .collection('items')
        .where('branch', isEqualTo: branch)
        .where('withButtons', isEqualTo: '1')
        .get(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator()); // Show a loading indicator
      }

      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Center(child: Text('No items found'));
      }

      final menuItems = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return MenuItem(
          imagePathFront: data['imagePathFront'],
          imagePathBack: data['imagePathBack'] ?? '0',
          itemName: data['itemName'],
          price: data['price'],
          itemCartImage: data['itemCartImage'],
          itemId: data['itemId'],
          weight: data['weight'], // Include if needed
          itemCategory: data['itemCategory'], // Include if needed
        );
      }).toList();

      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (1 / 1.2),
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return buildImageCard(context, item, branch);
        },
      );
    },
  );
}


Widget _buildGridView1(String branch) {
  return FutureBuilder<QuerySnapshot>(
    future: FirebaseFirestore.instance
        .collection('items')
        .where('branch', isEqualTo: branch)
        .where('withButtons', isEqualTo: '2')
        .get(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator()); // Show a loading indicator
      }

      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Center(child: Text('No items found'));
      }

      final menuItems = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return MenuItem(
          imagePathFront: data['imagePathFront'],
          imagePathBack: data['imagePathBack'] ?? '0',
          itemName: data['itemName'],
          price: data['price'],
          itemCartImage: data['itemCartImage'],
          itemId: data['itemId'],
          weight: data['weight'], // Include if needed
          itemCategory: data['itemCategory'], // Include if needed
        );
      }).toList();

      return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (1 / 1.2),
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return buildImageCard(context, item, branch);
        },
      );
    },
  );
}

  Widget buildImageCard(BuildContext context, MenuItem item, String branch) {
    return Stack(
      alignment: Alignment.topLeft,
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(item.imagePathFront, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: -22,
          left: -18,
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
              Provider.of<CartProvider>(context, listen: false).addToCart(
                branch,
                CartItemData(
                  itemId: item.itemId,
                  itemCartImage: item.itemCartImage,
                  itemName: item.itemName, // Or use a separate item name if available
                  price: item.price,
                  weight: item.weight,
                ),
              );
              print('Added to cart: ${item.itemName}');
            },
          ),
        ),
      ],
    );
  }
}

class MenuItem {
  final String imagePathFront;
  final String imagePathBack;
  final String itemName;
  int price;
  final String itemCartImage;
  final String itemId;
  int weight; // Optional
  final String itemCategory; // Optional

  MenuItem({
    required this.imagePathFront,
    required this.imagePathBack,
    required this.itemName,
    required this.price,
    required this.itemCartImage,
    required this.itemId,
    required this.weight,
    required this.itemCategory,
  });
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
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