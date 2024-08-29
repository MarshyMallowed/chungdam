
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RestaurantLocationsPage(),
    );
  }
}

class RestaurantLocationsPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find the nearest Chungdam Restaurant in your area!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search your location',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  RestaurantLocation(
                    title: 'MALATE',
                    images: [
                      'assets/malate1.jpg',
                      'assets/malate2.jpg',
                      'assets/malate3.jpg',
                    ],
                    mapUrl: 'https://maps.google.com/?q=Chungdam+Malate',
                  ),
                  RestaurantLocation(
                    title: 'BGC',
                    images: [
                      'assets/bgc1.jpg',
                      'assets/bgc2.jpg',
                      'assets/bgc3.jpg',
                    ],
                    mapUrl: 'https://maps.google.com/?q=Chungdam+BGC',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurant',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

class RestaurantLocation extends StatelessWidget {
  final String title;
  final List<String> images;
  final String mapUrl;

  RestaurantLocation({required this.title, required this.images, required this.mapUrl});

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          TextButton(
            onPressed: () => _launchURL(mapUrl),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: images.map((image) => Image.asset(image)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
