// lib/custom_widget.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// Define your custom widget here
class Map extends StatelessWidget {

  final TextEditingController _searchController = TextEditingController();
  Map({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                flex: 2,
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
              const Expanded(
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
                      images: [
                        'assets/BGC/1b.png',
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