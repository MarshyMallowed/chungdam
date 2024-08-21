import 'package:flutter/material.dart';
import 'package:chungdam/screens/logoutfunction.dart';
import 'package:chungdam/screens/homepage/start.dart';
import 'package:chungdam/screens/homepage/map.dart';
import 'package:chungdam/screens/navbot/menu_page.dart';
import 'package:chungdam/screens/cart_page.dart';

class HomePage extends StatefulWidget {
  final String firstName;
  final String phoneNumber;

  const HomePage({super.key, required this.firstName, required this.phoneNumber});
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _selectedDrawerItem = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
 


  Future<void> _precacheImages() async {
    // Precache all the images you use in your HomePage
     precacheImage(const AssetImage('assets/food4.jpg'), context);
     precacheImage(const AssetImage('assets/food3.jpg'), context);
     precacheImage(const AssetImage('assets/food2.jpg'), context);
     precacheImage(const AssetImage('assets/food5.jpg'), context);
     precacheImage(const AssetImage('assets/logo1.png'), context);
     precacheImage(const AssetImage('assets/logo2.png'), context);
     precacheImage(const AssetImage('assets/Malate/1m.jpg'), context);
     precacheImage(const AssetImage('assets/Malate/2m.jpg'), context);
     precacheImage(const AssetImage('assets/Malate/3m.jpg'), context);
     precacheImage(const AssetImage('assets/Malate/4m.jpg'), context);
     precacheImage(const AssetImage('assets/BGC/1b.png'), context);
    precacheImage(const AssetImage('assets/BGC/2b.jpg'), context);
     precacheImage(const AssetImage('assets/BGC/3b.jpg'), context);
    precacheImage(const AssetImage('assets/BGC/4b.jpg'), context);
     precacheImage(const AssetImage('assets/Parqal/1p.jpg'), context);
    precacheImage(const AssetImage('assets/Parqal/2p.jpg'), context);
    precacheImage(const AssetImage('assets/Parqal/3p.jpg'), context);
     precacheImage(const AssetImage('assets/Parqal/4p.png'), context);
     precacheImage(const AssetImage('assets/aboutlogo.png'), context);
     precacheImage(const AssetImage('assets/meat/meat1.png'), context);
     precacheImage(const AssetImage('assets/meat/meat2.png'), context);
     precacheImage(const AssetImage('assets/meat/meat3.jpg'), context);
     precacheImage(const AssetImage('assets/meat/meat4.jpg'), context);
     precacheImage(const AssetImage('assets/crab/crab1.png'), context);
     precacheImage(const AssetImage('assets/crab/crab2.png'), context);
     precacheImage(const AssetImage('assets/crab/crab3.png'), context);
     precacheImage(const AssetImage('assets/crab/crab4.jpg'), context);
     precacheImage(const AssetImage('assets/sashimi/sashimi3.jpg'), context);
     precacheImage(const AssetImage('assets/sashimi/sashimi1.jpg'), context);
     precacheImage(const AssetImage('assets/sashimi/sashimi2.jpg'), context);
     precacheImage(const AssetImage('assets/sashimi/sashimi4.jpg'), context);

    // ... precache other images
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      _scaffoldKey.currentState?.openEndDrawer();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _onDrawerItemTapped(String item, String route) {
    setState(() {
      _selectedDrawerItem = item;
    });
    Navigator.pop(context); // Close the drawer
    Navigator.pushNamed(context, route); // Navigate to the specified route
  }

  @override
  Widget build(BuildContext context) {
    // Define adjustable properties
    double marginValue = 1.0;
    double paddingValue = 10.0;
    double borderRadiusValue = 20.0;
    Color borderColor = Colors.black87; // Thick black border color
    Color containerBackgroundColor = const Color(0xFFFAF7E8); // Background color for the container
    Color thinBorderColor = Colors.black54; // Thin dark border color
    Color backgroundColor = const Color(0xFFFAF7E8); // Background color for the app
    Color navigationBarColor = const Color(0xFFeeeeee); // Background color for the navigation bars
    Color selectedItemColor = const Color(0xFFeeeeee); // Color for the selected drawer item

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundColor, // Set background color
      appBar: AppBar(
        backgroundColor: const Color(0xFF0c2344), // Dark blue color for AppBar
        title: _selectedIndex == 1
        ? const Text(
          "CHUNG DAM",
          style: TextStyle(
            color: Color(0xFFFAF7E8),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        )
        : const SizedBox.shrink(), // Returns an empty widget
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFFFAF7E8)),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open the drawer
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Color(0xFFFAF7E8)),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartPage()), // Navigate to the blank page
              );
            },
          ),
        ],
        elevation: 0,
      ),
      drawer: _buildDrawer(selectedItemColor),
      body: _buildBody(marginValue, paddingValue, borderRadiusValue, borderColor, thinBorderColor, containerBackgroundColor),
      bottomNavigationBar: _buildBottomNavigationBar(navigationBarColor),
      endDrawer: Drawer(
        child: Column(
          children: [
            Container(
              color: const Color(0xFF0c2344),
              child: DrawerHeader(
                margin: EdgeInsets.zero, // Ensure no extra margin is applied
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(color: Color(0xFF0c2344)),
                child: SafeArea(  // Wrapping content within a SafeArea
                  child: Row(
                    children: [
                      const SizedBox(width: 12),  // Adjust spacing
                      Image.asset('assets/logo1.png', height: 65),  // Adjust image height
                      const SizedBox(width: 8),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ' CHUNGDAM',
                            style: TextStyle(color: Color(0xFFFAF7E8), fontSize: 28),
                          ),
                          SizedBox(height: 2),  // Space between text lines
                          Text(
                            ' Korean Fine Dining',
                            style: TextStyle(color: Color(0xFFFAF7E8), fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.contact_phone),
              title: const Text('Contact Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactUsPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }


  Drawer _buildDrawer(Color selectedItemColor) {
    return Drawer(
      child: Column(
        children: <Widget>[
          _buildDrawerHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                _buildDrawerItem(Icons.person, 'Personal Details', selectedItemColor, '/personal_details'),
                _buildDrawerItem(Icons.card_giftcard, 'Vouchers', selectedItemColor, '/vouchers'),
                _buildDrawerItem(Icons.language, 'Language', selectedItemColor, '/language'),
                _buildDrawerItem(Icons.help_center, 'Help Center', selectedItemColor, '/help_center'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: _buildDrawerItem(Icons.logout, 'Log Out', selectedItemColor, '/blank'),
          ),
        ],
      ),
    );
  }

  Container _buildDrawerHeader() {
    return Container(
      color: const Color(0xFF051D40), // Dark blue background color
      padding: const EdgeInsets.only(left: 16.0, top: 44.0, bottom: 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo2.png', // Replace with your actual image path
            width: 60,
            height: 60,
          ),
          const SizedBox(width: 20),
          Text(
            'Hi, ${widget.firstName}',
            style: const TextStyle(
              color: Color(0xFFFAF7E8), // Light yellow color
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic, // Italicized text
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, Color selectedItemColor, String routeName) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: _selectedDrawerItem == title ? Colors.black : Colors.black,
        ),
      ),
      tileColor: _selectedDrawerItem == title ? selectedItemColor : null,
      onTap: () {
        if(title =='Log Out'){
          logoutAndNavigateToLogin(context);
        }    
        else{
          _onDrawerItemTapped(title, routeName);
        }   
      },
    );
  }

Widget _buildBody(double marginValue, double paddingValue, double borderRadiusValue, Color borderColor, Color thinBorderColor, Color containerBackgroundColor) {
  if (_selectedIndex == 0) {
    // Content for the Home page (when _selectedIndex is 0)
    return StartPage(marginValue: marginValue, paddingValue: paddingValue, borderColor: borderColor, borderRadiusValue: borderRadiusValue, thinBorderColor: thinBorderColor, containerBackgroundColor: containerBackgroundColor,);
  } else if (_selectedIndex == 1){
      return const MenuPage();
  } else if (_selectedIndex == 2) {
      // Content for the Restaurant Locations page (when _selectedIndex is 2)
      return Map();
    }  else {
    // Default content or error handling
    return const Center(
      child: Text('Invalid selection'),
    );
  }
}

  BottomNavigationBar _buildBottomNavigationBar(Color backgroundColor) {
    return BottomNavigationBar(
      backgroundColor: backgroundColor, // Set background color for BottomNavigationBar
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: _selectedIndex == 0 ? 24 : 30),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu, size: _selectedIndex == 1 ? 24 : 30),
          label: 'Menu',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on, size: _selectedIndex == 2 ? 24 : 30),
          label: 'Restaurant',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz, size: _selectedIndex == 3 ? 24 : 30),
          label: 'More',
        ),
      ],
      currentIndex: _selectedIndex,

      selectedItemColor: const Color(0xFFBC9C22), // Gold color for selected item
      unselectedItemColor: const Color(0xFF051D40), // Dark blue color for unselected items
      onTap: _onItemTapped,
    );
  }
}
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    double marginValue = 4.0; // Reduced margin
    double paddingValue = 4.0; // Reduced padding
    double borderRadiusValue = 8.0; // Reduced border radius
    Color containerBackgroundColor = Colors.white;
    Color borderColor = Colors.black;
    Color thinBorderColor = Colors.black54;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(
            color: Color(0xFFFAF7E8), // Set the text color
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
        backgroundColor: const Color(0xFF0c2344),
        iconTheme: const IconThemeData(color: Color(0xFFFAF7E8)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns text to the start
          children: [
            Center(
              child: Image.asset(
                'assets/aboutlogo.png',
                height: 250, // Adjusted height
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Chung Dam offers a gastronomic journey through the heart of Korean cuisine. Enjoy excellent Hanwoo meats, Wagyu cuts, and live King Crab in a sumptuous atmosphere. Our meticulously made dishes combine history with modern flair, resulting in an outstanding gastronomic experience. Reserve a table and enhance your Korean dining experience.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18, // Adjusted font size
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'FOR THE MEATS',
              style: TextStyle(
                color: Color(0xFF0c2344),
                fontSize: 22, // Adjusted font size
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'We offer premium meats that have been perfectly aged, offering a variety of levels of tenderness and unique flavors to satisfy any palate.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18, // Adjusted font size
              ),
            ),
            const SizedBox(height: 20),
            // Image Collage
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: marginValue, vertical: marginValue),
                  padding: EdgeInsets.all(paddingValue),
                  decoration: BoxDecoration(
                    color: containerBackgroundColor, // Background color for the container
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    border: Border.all(color: borderColor, width: 2.0), // Thinner border
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 1.0,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        const Color(0xFF0c2344).withOpacity(0.3), // Dark blue opacity
                        BlendMode.srcATop,
                      ),
                      child: Column(
                        children: [
                          // Top Row (2 images)
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: thinBorderColor, width: 1.0), // Added border
                                    image: const DecorationImage(
                                      image: AssetImage('assets/meat/meat1.png'), // First image
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 160, // Reduced height
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: thinBorderColor, width: 1.0), // Added border
                                        image: const DecorationImage(
                                          image: AssetImage('assets/meat/meat2.png'), // Second image
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 80, // Reduced height
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: thinBorderColor, width: 1.0), // Added border
                                        image: const DecorationImage(
                                          image: AssetImage('assets/meat/meat3.jpg'), // Third image
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 80, // Reduced height
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Bottom Image (spanning two columns)
                          Container(
                            margin: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: thinBorderColor, width: 1.0), // Added border
                              image: const DecorationImage(
                                image: AssetImage('assets/meat/meat4.jpg'), // Fourth image
                                fit: BoxFit.cover,
                              ),
                            ),
                            height: 140, // Reduced height
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Text(
              'FOR THE CRAB',
              style: TextStyle(
                color: Color(0xFF0c2344),
                fontSize: 22, // Adjusted font size
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Savor the pinnacle of freshness with our live king crab, which is prized for its delicate, sweet meat and abundant oceanic flavor.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18, // Adjusted font size
              ),
            ),
            const SizedBox(height: 20),
            // Image Collage
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: marginValue, vertical: marginValue),
                  padding: EdgeInsets.all(paddingValue),
                  decoration: BoxDecoration(
                    color: containerBackgroundColor, // Background color for the container
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    border: Border.all(color: borderColor, width: 2.0), // Thinner border
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 1.0,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        const Color(0xFF0c2344).withOpacity(0.3), // Dark blue opacity
                        BlendMode.srcATop,
                      ),
                      child: Column(
                        children: [
                          // Top Row (2 images)
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: thinBorderColor, width: 1.0), // Added border
                                    image: const DecorationImage(
                                      image: AssetImage('assets/crab/crab1.png'), // First image
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 160, // Reduced height
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: thinBorderColor, width: 1.0), // Added border
                                        image: const DecorationImage(
                                          image: AssetImage('assets/crab/crab2.png'), // Second image
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 80, // Reduced height
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: thinBorderColor, width: 1.0), // Added border
                                        image: const DecorationImage(
                                          image: AssetImage('assets/crab/crab3.png'), // Third image
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 80, // Reduced height
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Bottom Image (spanning two columns)
                          Container(
                            margin: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: thinBorderColor, width: 1.0), // Added border
                              image: const DecorationImage(
                                image: AssetImage('assets/crab/crab4.jpg'), // Fourth image
                                fit: BoxFit.cover,
                              ),
                            ),
                            height: 140, // Reduced height
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            const Text(
              'FOR THE SASHIMI',
              style: TextStyle(
                color: Color(0xFF0c2344),
                fontSize: 22, // Adjusted font size
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Our extensive assortment of flawlessly sliced raw fish and seafood has been carefully chosen to ensure maximum freshness and flavor.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18, // Adjusted font size
              ),
            ),
            const SizedBox(height: 20),
            // Image Collage
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: marginValue, vertical: marginValue),
                  padding: EdgeInsets.all(paddingValue),
                  decoration: BoxDecoration(
                    color: containerBackgroundColor, // Background color for the container
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    border: Border.all(color: borderColor, width: 2.0), // Thinner border
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 1.0,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        const Color(0xFF0c2344).withOpacity(0.3), // Dark blue opacity
                        BlendMode.srcATop,
                      ),
                      child: Column(
                        children: [
                          // Top Row (2 images)
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: thinBorderColor, width: 1.0), // Added border
                                    image: const DecorationImage(
                                      image: AssetImage('assets/sashimi/sashimi1.jpg'), // First image
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 160, // Reduced height
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: thinBorderColor, width: 1.0), // Added border
                                        image: const DecorationImage(
                                          image: AssetImage('assets/sashimi/sashimi2.jpg'), // Second image
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 80, // Reduced height
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8.0),
                                        border: Border.all(color: thinBorderColor, width: 1.0), // Added border
                                        image: const DecorationImage(
                                          image: AssetImage('assets/sashimi/sashimi3.jpg'), // Third image
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 80, // Reduced height
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Bottom Image (spanning two columns)
                          Container(
                            margin: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: thinBorderColor, width: 1.0), // Added border
                              image: const DecorationImage(
                                image: AssetImage('assets/sashimi/sashimi4.jpg'), // Fourth image
                                fit: BoxFit.cover,
                              ),
                            ),
                            height: 140, // Reduced height
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Contact Us',
          style: TextStyle(
            color: Color(0xFFFAF7E8), // Set the text color
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
        backgroundColor: const Color(0xFF0c2344),
        iconTheme: const IconThemeData(color: Color(0xFFFAF7E8)),
      ),
      body: ListView(
        children: const [
          ContactTile(
            locationName: "MALATE",
            phoneNumber: "+639********",
            email: "sample@gmail.com",
          ),
          ContactTile(
            locationName: "PARQAL",
            phoneNumber: "+639********",
            email: "sample@gmail.com",
          ),
          ContactTile(
            locationName: "BGC",
            phoneNumber: "+639********",
            email: "sample@gmail.com",
          ),
        ],
      ),
    );
  }
}

class ContactTile extends StatelessWidget {
  final String locationName;
  final String phoneNumber;
  final String email;

  const ContactTile({super.key, required this.locationName, required this.phoneNumber, required this.email});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading: const Icon(Icons.location_on, color: Colors.red, size: 30),
        title: Text(
          locationName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              phoneNumber,
              style: const TextStyle(color: Colors.black87, fontSize: 16),
            ),
            Text(
              email,
              style: const TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ],
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      ),
    );
  }
}
