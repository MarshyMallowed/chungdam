import 'package:flutter/material.dart';
import 'blank_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'logoutFunction.dart';
import 'package:url_launcher/url_launcher.dart';
Future<String?> getUserNameFromFirestore(String uid) async {
  DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  return doc.exists ? doc['displayName'] as String? : null;
}

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
  String? _displayName;
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _fetchDisplayName();
  }

  Future<void> _fetchDisplayName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final String? name = await getUserNameFromFirestore(user.uid);
      setState(() {
        _displayName = name ?? widget.firstName; // Fall back to the passed name if Firestore data is not available
      });
    }
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
                MaterialPageRoute(builder: (context) => const BlankPage()), // Navigate to the blank page
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
                _buildDrawerItem(Icons.payment, 'Payment Method', selectedItemColor, '/payment_method'),
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
            'Hi, ${_displayName ?? widget.firstName}',
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            const Center(
              child: Column(
                children: [
                  Text(
                    'Welcome to',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'CHUNG DAM!',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD4AF37), // Gold color
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: marginValue, vertical: marginValue),
                  padding: EdgeInsets.all(paddingValue),
                  decoration: BoxDecoration(
                    color: containerBackgroundColor,
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    border: Border.all(color: borderColor, width: 3.0),
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
                        const Color(0xFF0c2344).withOpacity(0.3),
                        BlendMode.srcATop,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: thinBorderColor, width: 1.0),
                                    image: const DecorationImage(
                                      image: AssetImage('assets/food4.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  height: 250,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(color: thinBorderColor, width: 1.0),
                                        image: const DecorationImage(
                                          image: AssetImage('assets/food3.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 100,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(color: thinBorderColor, width: 1.0),
                                        image: const DecorationImage(
                                          image: AssetImage('assets/food2.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 145,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: thinBorderColor, width: 1.0),
                              image: const DecorationImage(
                                image: AssetImage('assets/food5.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            height: 100,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30.0,
                  right: 30.0,
                  child: ElevatedButton(
                    onPressed: () {
                      // Order Now Logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFfff6cd),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 5.0,
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'ORDER NOW!',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadiusValue),
                  child: Image.asset(
                    'assets/food5.jpg',
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  } else if (_selectedIndex == 2) {
      // Content for the Restaurant Locations page (when _selectedIndex is 2)
      return Scaffold(
        body: Container(
          color: const Color(0xFFFAF7E8),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search your location',
                  hintStyle: const TextStyle(color: Color(0xFF172A5A)), // Hint text color
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF172A5A)), // Icon color
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Color(0xFF172A5A)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Color(0xFF172A5A)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Color(0xFF172A5A)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Expanded(
                flex: 8,
                child: Center(
                  child: Text(
                    'Find the nearest Chung Dam Restaurant in your area!',
                    style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF172A5A),
                    ),
                  textAlign: TextAlign.center,
                ),
              ),
              ),
              const SizedBox(height: 5),
              Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RestaurantLocation(
                      title: 'MALATE',
                      images: [
                        'assets/Malate/1m.jpg',
                        'assets/Malate/2m.jpg',
                        'assets/Malate/3m.jpg',
                        'assets/Malate/4m.jpg'
                      ],
                      mapUrl: 'https://maps.app.goo.gl/UhWveKZ9NPYHp7pNA',
                    ),
                    RestaurantLocation(
                      title: 'BGC',
                      images: const [
                        'assets/BGC/1b.webp',
                        'assets/BGC/2b.jpg',
                        'assets/BGC/3b.jpg',
                        'assets/BGC/4b.jpg',
                      ],
                      mapUrl: 'https://maps.app.goo.gl/dSp6D5yQyd5iekZk8',
                    ),
                    RestaurantLocation(
                      title: 'PARQAL',
                      images: [
                        'assets/Parqal/1p.jpg',
                        'assets/Parqal/2p.jpg',
                        'assets/Parqal/3p.jpg',
                        'assets/Parqal/4p.png'
                      ],
                      mapUrl: 'https://maps.app.goo.gl/uGy5cXjkLhVNtePk7',
                    ),
                  ],
                ),
              ),
            ),
            ],
          ),
        ),
      );
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


class RestaurantLocation extends StatefulWidget {
  final String title;
  final List<String> images;
  final String mapUrl;

  const RestaurantLocation({super.key, 
    required this.title,
    required this.images,
    required this.mapUrl,
  });

  @override
  // ignore: library_private_types_in_public_api
  _RestaurantLocationState createState() => _RestaurantLocationState();
}

class _RestaurantLocationState extends State<RestaurantLocation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start the animation when the widget is built
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20),
      color: const Color(0xFFE0E0E0),
      child: Column(
        children: [
          Stack(
            children: [
              AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(4.0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: widget.images.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFeeeeee), width: 2.0),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(widget.images[index], fit: BoxFit.cover),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: ElevatedButton.icon(
                  onPressed: () => _launchURL(widget.mapUrl),
                  icon: const Icon(Icons.location_on, color: Colors.red),
                  label: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF9F0D9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.black, width: 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
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
