import 'package:flutter/material.dart';

class SpecialMenuSashimiPage extends StatefulWidget {
  final int index;

  SpecialMenuSashimiPage(this.index);

  @override
  _SpecialMenuSashimiPageState createState() => _SpecialMenuSashimiPageState();
}

class _SpecialMenuSashimiPageState extends State<SpecialMenuSashimiPage> {
  // Define your assets for SpecialMenuSashimiPage
  final List<String> sashimiSetImages = [
    'honmagurosashimiset1.png',
    'honmagurosashimiset2.png',
    'flatfish1.png',
    'flatfish2.png',
    'flatfish3.png',
    'flander1.png',
    'flander2.png',
    'flander3.png',
    'turbot1.png',
    'turbot2.png',
    'turbot3.png',
  ];

  final List<String> freshSalmonSetImages = [
    'salmonset1.png',
    'salmonset2.png',
    'freshsalmon.png',
    'liveflatfish.png',
    'freshsalmon+liveflatfish.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Color(0xFFFAF7E8),
      body: buildPageContent(context, sashimiSetImages, freshSalmonSetImages),
    );
  }
}

class SpecialMenuSashimiMalatePage extends StatefulWidget {
  final int index;

  SpecialMenuSashimiMalatePage(this.index);

  @override
  _SpecialMenuSashimiMalatePageState createState() => _SpecialMenuSashimiMalatePageState();
}

class _SpecialMenuSashimiMalatePageState extends State<SpecialMenuSashimiMalatePage> {
  // Define your assets for SpecialMenuSashimiMalatePage
  final List<String> sashimiSetImages = [
    'honmagurosashimiset1m.png',
    'honmagurosashimiset2m.png',
    'flatfish1m.png',
    'flatfish2m.png',
    'flatfish3.png',
    'flander1m.png',
    'flander2m.png',
    'flander3.png',
    'turbot1m.png',
    'turbot2m.png',
    'turbot3.png',
  ];

  final List<String> freshSalmonSetImages = [
    'salmonset1m.png',
    'salmonset2m.png',
    'freshsalmon.png',
    'liveflatfish.png',
    'freshsalmon+liveflatfish.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Color(0xFFFAF7E8),
      body: buildPageContent(context, sashimiSetImages, freshSalmonSetImages),
    );
  }
}

// Common AppBar builder
AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Color(0xFF0C2344),
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Color(0xFFFAF7E8)),
      onPressed: () => Navigator.of(context).pop(),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.shopping_cart, color: Color(0xFFFAF7E8)),
        onPressed: () {
          // Implement cart action here
          print('Shopping cart tapped');
        },
      ),
    ],
  );
}

// Common content builder
Widget buildPageContent(BuildContext context, List<String> sashimiSetImages, List<String> freshSalmonSetImages) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/others/background2.png'),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
      ),
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              _buildOutlinedText('HON MAGURO SASHIMI SET'),
              _buildImageWithButton('assets/specialmenusashimi/honmaguroset.png'),
              SizedBox(height: 1),
              buildHorizontalImageList(),
              SizedBox(height: 60),
              _buildOutlinedText('SASHIMI SET'),
              SizedBox(height: 25),
              buildGridView(context, sashimiSetImages),
              SizedBox(height: 60),
              _buildOutlinedText('ABALONE SASHIMI'),
              SizedBox(height: 25),
              buildGridView(context, [
                'grilledabalone1.png',
                'grilledabalone2.png',
                'steamedabalone1.png',
                'steamedabalone2.png',
              ]),
              SizedBox(height: 60),
              _buildOutlinedText('FRESH SALMON SET'),
              SizedBox(height: 25),
              buildGridView(context, freshSalmonSetImages),
            ],
          ),
        ),
      ),
    ],
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
            ..color = Color(0xFFFAF7E8),
        ),
      ),
      // Solid text
      Text(
        text,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0c2344),
        ),
      ),
    ],
  );
}

Widget _buildImageWithButton(String imagePathFront) {
  return Stack(
    alignment: Alignment.center,
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 4.0, right: 4.0),
        margin: EdgeInsets.all(1),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            imagePathFront,
            width: 330,
            height: 250,
          ),
        ),
      ),
      Positioned(
        top: 10,
        left: -12,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: Color(0xFF0C2344),
            foregroundColor: Color(0xFFFAF7E8),
            padding: EdgeInsets.zero,
            minimumSize: Size(25, 25),
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

Widget buildHorizontalImageList() {
  return Container(
    height: 210,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? 20.0 : 0.0, // Adds extra padding only to the first item
            right: index == 5 ? 20.0 : 0.0, // Adds extra padding only to the last item
            top: 0.0,
          ),
          child: buildImageCard(
            context,
            [
              'bigeyeakami.png',
              'bluefinakami.png',
              'betkkopsal.png',
              'judoro.png',
              'odoro.png',
              'hwangsechi.png',
            ][index],
          ),
        );
      },
    ),
  );
}


Widget buildGridView(BuildContext context, List<String> imageNames) {
  return GridView.count(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    crossAxisCount: 2,
    childAspectRatio: (1 / 1.2),
    crossAxisSpacing: 7,
    mainAxisSpacing: 7,
    padding: EdgeInsets.symmetric(horizontal: 16),
    children: imageNames.map((imageName) => buildImageCard(context, imageName)).toList(),
  );
}

Widget buildImageCard(BuildContext context, String imageName) {
  return Stack(
    alignment: Alignment.topLeft,
    clipBehavior: Clip.none,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            'assets/specialmenusashimi/$imageName',
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
        top: -10,
        left: -12,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            backgroundColor: Color(0xFF0C2344),
            foregroundColor: Color(0xFFFAF7E8),
            padding: EdgeInsets.zero,
            minimumSize: Size(25, 25),
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
