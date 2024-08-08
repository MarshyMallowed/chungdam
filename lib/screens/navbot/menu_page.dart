import 'package:flutter/material.dart';
import 'package:chungdam/screens/menu/menupage.dart';
import 'package:chungdam/screens/menu/hanwooset.dart';
import 'package:chungdam/screens/menu/hanwooalacarte.dart';
class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  MenuPageState createState() => MenuPageState();
}

class MenuItem {
  final String name;
  final String imagePath;
  final int index;

  MenuItem({required this.name, required this.imagePath, required this.index});

  Widget getPage() {
    switch (index) {
      case 1:
        return HanwooSetPage(index);
      case 2:
        return HanwooAlaCartePage(index);
      case 3:
        return WagyuSetPage(index);
      case 4:
        return SamgyeopsalPage(index);
      default:
        return ErrorPage();  // Create an ErrorPage or a default page to handle unexpected cases
    }
  }
}




class MenuPageState extends State<MenuPage> {
  List<MenuItem> menuItems = [
    MenuItem(name: 'HANWOO SET', imagePath: 'assets/meat/meat1.png', index: 1),
    MenuItem(
        name: 'HANWOO ALA CARTE', imagePath: 'assets/meat/meat2.png', index: 2),
    MenuItem(name: 'WAGYU SET', imagePath: 'assets/meat/meat3.jpg', index: 3),
    MenuItem(name: 'SAMGYEOPSAL', imagePath: 'assets/meat/meat3.jpg', index: 4),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFFAF7E8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              Center(child: Text("메뉴", style: TextStyle(fontSize: 33,
                  fontWeight: FontWeight.bold,
                  color: Colors.black), textAlign: TextAlign.center)),
              Center(child: Text("MENU", style: TextStyle(fontSize: 33,
                  fontWeight: FontWeight.bold,
                  color: Colors.black), textAlign: TextAlign.center)),
              SizedBox(height: 15),
              ...menuItems.map((item) => buildMenuItem(context, item)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(BuildContext context, MenuItem item) {
    return Container(
      // Use the LayoutBuilder to get the maximum width while allowing for responsive padding
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth * 0.9, // Set the width to 90% of the maximum width
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),  // Increased horizontal margin to center the container
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0.5,  // Reduced spread radius
                  blurRadius: 3,  // Reduced blur radius
                  offset: Offset(0, 2),  // Reduced offset
                ),
              ],
              border: Border.all(color: Color(0xFF0c2344), width: 1.5),  // Slightly thinner border
              borderRadius: BorderRadius.circular(15),  // Smaller border radius
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),  // Reduced padding
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),  // Smaller radius for the image
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.asset(item.imagePath, fit: BoxFit.cover),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD4AF37),
                    minimumSize: Size(double.infinity, 40),  // Reduced button height
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 8),  // Reduced padding
                  ),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => item.getPage()),
                  ),
                  child: Text(
                    item.name,
                    style: TextStyle(fontSize: 20, color: Color(0xFF0c2344), fontWeight: FontWeight.bold),  // Smaller font size
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}