import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chungdam/screens/menu/branch_provider.dart';
import 'package:chungdam/screens/menu/menu_items.dart';


class BranchSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/others/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            padding: EdgeInsets.all(40),
            children: ['MALATE', 'BGC', 'PARQAL'].map((branch) {
              return Container(
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFffeead),
                    foregroundColor: Colors.black,
                    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                  onPressed: () {
                    // Update the provider with the selected branch
                    Provider.of<BranchProvider>(context, listen: false).setBranch(branch);

                    // Navigate to MainPage, default to MenuPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MenuPage()),
                    );
                  },
                  child: Text(branch),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}


class MenuPage extends StatefulWidget {
  @override
  MenuPageState createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
    // Fetch branch-specific items from the provider or wherever appropriate
  }

  @override
  Widget build(BuildContext context) {
    // Get branch-specific menu items from provider or other state management
    final branch = Provider.of<BranchProvider>(context).selectedBranch;
    List<MenuItem> menuItems;

    switch (branch) {
      case 'MALATE':
        menuItems = [
          MenuItem(name: 'MYEONGPHUM (MALATE)', imagePath: 'assets/others/myeongphum.png', index: 1),
          MenuItem(name: 'WAGYU (MALATE)', imagePath: 'assets/others/wagyu.jpg', index: 2),
          MenuItem(name: 'USA PRIME (MALATE)', imagePath: 'assets/others/usaprime.jpg', index: 3),
          MenuItem(name: 'SAMGYEOPSAL (MALATE)', imagePath: 'assets/others/samgyupsal.jpg', index: 4),
          MenuItem(name: 'SINGLE MENU (MALATE)', imagePath: 'assets/others/singlemenu.jpg', index: 5),
          MenuItem(name: 'STEW (MALATE)', imagePath: 'assets/others/stew.jpg', index: 6),
          MenuItem(name: 'SPECIAL MENU: MEAT (MALATE)', imagePath: 'assets/others/meat.jpg', index: 7),
          MenuItem(name: 'SPECIAL MENU: CRAB (MALATE)', imagePath: 'assets/others/crab.png', index: 8),
          MenuItem(name: 'SPECIAL MENU: SASHIMI (MALATE)', imagePath: 'assets/others/sashimi.png', index: 9),
          MenuItem(name: 'ORIGIN FROM KOREA (MALATE)', imagePath: 'assets/others/originfromkorea.jpg', index: 10),
          MenuItem(name: 'BEVERAGES (MALATE)', imagePath: 'assets/others/beverage.png', index: 11), // Add more items specific to BGC
        ];
        break;
      case 'PARQAL':
        menuItems = [
          MenuItem(name: 'MYEONGPHUM (PARQAL)', imagePath: 'assets/others/myeongphum.png', index: 1),
          MenuItem(name: 'WAGYU (PARQAL)', imagePath: 'assets/others/wagyu.jpg', index: 2),
          MenuItem(name: 'USA PRIME (PARQAL)', imagePath: 'assets/others/usaprime.jpg', index: 3),
          MenuItem(name: 'SAMGYEOPSAL (PARQAL)', imagePath: 'assets/others/samgyupsal.jpg', index: 4),
          MenuItem(name: 'SINGLE MENU (PARQAL)', imagePath: 'assets/others/singlemenu.jpg', index: 5),
          MenuItem(name: 'STEW (PARQAL)', imagePath: 'assets/others/stew.jpg', index: 6),
          MenuItem(name: 'SPECIAL MENU: MEAT (PARQAL)', imagePath: 'assets/others/meat.jpg', index: 7),
          MenuItem(name: 'SPECIAL MENU: CRAB (PARQAL)', imagePath: 'assets/others/crab.png', index: 8),
          MenuItem(name: 'SPECIAL MENU: SASHIMI (PARQAL)', imagePath: 'assets/others/sashimi.png', index: 9),
          MenuItem(name: 'ORIGIN FROM KOREA (PARQAL)', imagePath: 'assets/others/originfromkorea.jpg', index: 10),
          MenuItem(name: 'BEVERAGES (PARQAL)', imagePath: 'assets/others/beverage.png', index: 11) // Add more items specific to BGC
        ];
        break;
      case 'BGC':
        menuItems = [
          MenuItem(name: 'MYEONGPHUM (BGC)', imagePath: 'assets/others/myeongphum.png', index: 1),
          MenuItem(name: 'WAGYU (BGC)', imagePath: 'assets/others/wagyu.jpg', index: 2),
          MenuItem(name: 'USA PRIME (BGC)', imagePath: 'assets/others/usaprime.jpg', index: 3),
          MenuItem(name: 'SAMGYEOPSAL (BGC)', imagePath: 'assets/others/samgyupsal.jpg', index: 4),
          MenuItem(name: 'SINGLE MENU (BGC)', imagePath: 'assets/others/singlemenu.jpg', index: 5),
          MenuItem(name: 'STEW (BGC)', imagePath: 'assets/others/stew.jpg', index: 6),
          MenuItem(name: 'SPECIAL MENU: MEAT (BGC)', imagePath: 'assets/others/meat.jpg', index: 7),
          MenuItem(name: 'SPECIAL MENU: CRAB (BGC)', imagePath: 'assets/others/crab.png', index: 8),
          MenuItem(name: 'SPECIAL MENU: SASHIMI (BGC)', imagePath: 'assets/others/sashimi.png', index: 9),
          MenuItem(name: 'ORIGIN FROM KOREA (BGC)', imagePath: 'assets/others/originfromkorea.jpg', index: 10),
          MenuItem(name: 'BEVERAGES (BGC)', imagePath: 'assets/others/beverage.png', index: 11),
          MenuItem(name: 'KOREAN ICE CREAM (BGC)', imagePath: 'assets/others/icecream.png', index: 12), // Add more items specific to BGC
// Add more items specific to BGC
        ];
        break;
      default:
        menuItems = []; // Empty list if no valid branch
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0c2344),
        title: Text("CHUNG DAM",
            style: TextStyle(
                color: Color(0xFFFAF7E8), fontSize: 25, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Color(0xFFFAF7E8)),
            onPressed: () {
              // Logic for cart page
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFFAF7E8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 70),
              Center(
                  child: Text("메뉴",
                      style: TextStyle(
                          fontSize: 33,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      textAlign: TextAlign.center)),
              Center(
                  child: Text("MENU",
                      style: TextStyle(
                          fontSize: 33,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      textAlign: TextAlign.center)),
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth * 0.9,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0.5,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
              border: Border.all(color: Color(0xFF0c2344), width: 1.5),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.asset(item.imagePath, fit: BoxFit.cover),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFffeead),
                    minimumSize: Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => item.getPage()),
                  ),
                  child: Text(
                    item.name,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0c2344)),
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