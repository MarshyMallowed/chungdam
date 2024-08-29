import 'package:flutter/material.dart';

class BeveragesPage extends StatefulWidget {
  final int index;

  BeveragesPage(this.index);

  @override
  _BeveragesPageState createState() => _BeveragesPageState();
}

class _BeveragesPageState extends State<BeveragesPage> {
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
                  Stack(
                    children: [
                      // Outline text
                      Text(
                        'ALCOHOLIC DRINKS',
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
                        'ALCOHOLIC DRINKS',
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
                    'tequilajcuervo.png',
                    'svedkavodka.png',
                    'absolutevodka.png',
                    'hennessyvsop.png',
                    'hennessyxo.png',
                    'wbhoegarden.png',
                    'wbstella.png',
                    'sanmigpilsen.png',
                    'sanmiglight.png',
                    'sanmigapple.png',
                    'chumchurumsoju.png',
                    'freshsoju.png',
                    'peachsoju.png',
                    'strawberrysoju.png',
                    'jinroisback.png',
                    'makgolli.png',
                    'baekseju.png',
                    'bokjunja.png',
                    'hwayosoju17.png',
                    'hwayosoju25.png',
                    'hwayosoju41-375.png',
                    'hwayosoju41-500.png',
                    'hwayosojuxp.png',
                  ]),
                  SizedBox(height: 50),
                  Stack(
                    children: [
                      // Outline text
                      Text(
                        'SOFT DRINKS',
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
                        'SOFT DRINKS',
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
                    'coke.png',
                    'cokezero.png',
                    'sprite.png',
                    'royal.png',
                  ]),
                  SizedBox(height: 50),
                  Stack(
                    children: [
                      // Outline text
                      Text(
                        'SHAKE & JUICE',
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
                        'SHAKE & JUICE',
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
                    'strawberry.png',
                    'kiwi.png',
                    'watermelon.png',
                    'yellowmango.png',
                    'greenmango.png',
                    'mineralwater.png',
                    'freshlemonade.png',
                    'solalemon.png',
                    'solapeach.png', // Fix: Added missing comma here
                    'pineapplejuice.png',
                    'mangojuice.png',
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
            child: Image.asset('assets/beverage/$imageName', fit: BoxFit.cover),
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



class BeveragesBGCPage extends StatefulWidget {
  final int index;

  BeveragesBGCPage(this.index);

  @override
  _BeveragesBGCPageState createState() => _BeveragesBGCPageState();
}

class _BeveragesBGCPageState extends State<BeveragesBGCPage> {
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
                  Stack(
                    children: [
                      // Outline text
                      Text(
                        'ALCOHOLIC DRINKS',
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
                        'ALCOHOLIC DRINKS',
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
                    'josecuervomix.png',
                    'tequilajcuervo.png',
                    'hennessyvsop.png',
                    'hennessyxo.png',
                    'wbhoegarden.png',
                    'wbstella.png',
                    'sanmigpilsen.png',
                    'sanmiglight.png',
                    'sanmigapple.png',
                    'chumchurumsoju.png',
                    'freshsoju.png',
                    'greengrapesoju.png',
                    'grapefruitsoju.png',
                    'jinroisback.png',
                    'jinrolight.png',
                    'makgolli.png',
                    'baeksejum.png',
                    'bokjunja.png',
                    'hwayosoju17.png',
                    'hwayosoju25.png',
                    'hwayosoju41-375.png',
                    'hwayosoju41-500.png',
                    'hwayosojuxp.png',
                  ]),
                  SizedBox(height: 50),
                  Stack(
                    children: [
                      // Outline text
                      Text(
                        'SOFT DRINKS',
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
                        'SOFT DRINKS',
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
                    'coke.png',
                    'cokezero.png',
                    'sprite.png',
                    'royal.png',
                  ]),
                  SizedBox(height: 50),
                  Stack(
                    children: [
                      // Outline text
                      Text(
                        'SHAKE & JUICE',
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
                        'SHAKE & JUICE',
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
                    'strawberry.png',
                    'kiwi.png',
                    'watermelon.png',
                    'yellowmango.png',
                    'greenmango.png',
                    'mineralwater.png',
                    'freshlemonade.png',
                    'solalemon.png',
                    'solapeach.png', // Fix: Added missing comma here
                    'pineapplejuice.png',
                    'mangojuice.png',
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
            child: Image.asset('assets/beverage/$imageName', fit: BoxFit.cover),
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


class BeveragesMalatePage extends StatefulWidget {
  final int index;

  BeveragesMalatePage(this.index);

  @override
  _BeveragesMalatePageState createState() => _BeveragesMalatePageState();
}

class _BeveragesMalatePageState extends State<BeveragesMalatePage> {
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
                  Stack(
                    children: [
                      // Outline text
                      Text(
                        'ALCOHOLIC DRINKS',
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
                        'ALCOHOLIC DRINKS',
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
                    'wbhoegardenm.png',
                    'wbstellam.png',
                    'sanmigpilsenm.png',
                    'sanmiglightm.png',
                    'sanmigapplem.png',
                    'chumchurumsojum.png',
                    'freshsojum.png',
                    'greengrapesojum.png',
                    'grapefruitsojum.png',
                    'jinroisbackm.png',
                    'hallasan.png',
                    'makgollim.png',
                    'baeksejum.png',
                    'bokjunja.png',
                    'hwayosoju17.png',
                    'hwayosoju25.png',
                    'hwayosoju41-375.png',
                    'hwayosoju41-500.png',
                    'hwayosojuxp.png',
                  ]),
                  SizedBox(height: 50),
                  Stack(
                    children: [
                      // Outline text
                      Text(
                        'SOFT DRINKS',
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
                        'SOFT DRINKS',
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
                    'cokem.png',
                    'cokezerom.png',
                    'spritem.png',
                    'royalm.png',
                  ]),
                  SizedBox(height: 50),
                  Stack(
                    children: [
                      // Outline text
                      Text(
                        'SHAKE & JUICE',
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
                        'SHAKE & JUICE',
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
                    'strawberrym.png',
                    'kiwim.png',
                    'watermelonm.png',
                    'yellowmangom.png',
                    'greenmangom.png',
                    'mineralwater.png',
                    'solalemonm.png',
                    'solapeachm.png', // Fix: Added missing comma here
                    'pineapplejuicem.png',
                    'mangojuicem.png',
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
            child: Image.asset('assets/beverage/$imageName', fit: BoxFit.cover),
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