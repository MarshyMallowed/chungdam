import 'package:flutter/material.dart';

class OrderStatusPage extends StatefulWidget {
  final String transactionId;
  const OrderStatusPage( {   
    super.key,
    required this.transactionId,
    });

  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _previousImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 30), // Increased duration for slower rotation
      vsync: this,
    )..repeat(); // Repeat the animation indefinitely
    String Id = widget.transactionId;
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear, // Use a linear curve for smooth continuous rotation
      ),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  int _getImageIndex(double animationValue) {
    return (animationValue * 10).floor(); // Divide into 10 segments for 10 images
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0c2344), // Dark blue color
        iconTheme: const IconThemeData(color: Colors.white), // Set the icon color to white
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Use the arrow back icon
          onPressed: () => Navigator.pop(context),
          color: Colors.white, // Set the arrow back button color to white
        ),
        title: const Text(''), // Empty title to remove "Order Status" from the top bar
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFFAF7E8), // Light background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20), // Space from the top bar
            const Text(
              'Order Status',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                int currentImageIndex = _getImageIndex(_animation.value);
                // Apply opacity only when switching images
                if (_previousImageIndex != currentImageIndex) {
                  _previousImageIndex = currentImageIndex;
                  return AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(milliseconds: 500), // Quick fade-in effect
                    child: RotationTransition(
                      turns: _animation,
                      child: Image.asset(
                        'assets/image_$currentImageIndex.png', // Switch between images
                        height: 150,
                      ),
                    ),
                  );
                } else {
                  return RotationTransition(
                    turns: _animation,
                    child: Image.asset(
                      'assets/image_$currentImageIndex.png', // Stay on the current image
                      height: 150,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 30),
            _buildOrderStatusItem(
              context,
              icon: Icons.access_time,
              title: 'Order Received',
              subtitle: '11:10 AM, 30 August 2024',
              isCompleted: true,
              isFirst: true,
            ),
            _buildOrderStatusItem(
              context,
              icon: Icons.receipt,
              title: 'Preparing Order',
              subtitle: '11:15 AM, 30 August 2024',
              isCompleted: true,
            ),
            _buildOrderStatusItem(
              context,
              icon: Icons.local_shipping,
              title: 'Out for Delivery',
              subtitle: '',
              isCompleted: false,
              iconColor: const Color(0xFF866b02), // Custom color for "Out for Delivery"
            ),
            _buildOrderStatusItem(
              context,
              icon: Icons.check_circle,
              title: 'Delivered',
              subtitle: '',
              isCompleted: false,
              isLast: true,
              iconColor: const Color(0xFF866b02), // Custom color for "Delivered"
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatusItem(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isCompleted,
    bool isFirst = false,
    bool isLast = false,
    Color? iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 60.0), // Move the entire row further to the right
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                icon,
                color: isCompleted
                    ? const Color(0xFF0c2344)
                    : iconColor ?? Colors.grey, // Use the custom color if provided
                size: 30, // Size of the icons
              ),
              if (!isLast) // Show the vertical line except for the last item
                Container(
                  height: 60, // Height for the line
                  child: VerticalDivider(
                    color: isCompleted
                        ? const Color(0xFF0c2344)
                        : iconColor ?? Colors.grey, // Use the custom color if provided
                    thickness: 2.0, // Thickness of the line
                  ),
                ),
            ],
          ),
          const SizedBox(width: 15), // Increased space between the icon and text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18, // Font size for the title
                  fontWeight: FontWeight.bold,
                  color: isCompleted ? const Color(0xFF0c2344) : iconColor ?? Colors.grey,
                ),
              ),
              if (subtitle.isNotEmpty)
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14, // Font size for the subtitle
                    color: Colors.grey,
                  ),
                ),
              const SizedBox(height: 10), // Spacing between items
            ],
          ),
        ],
      ),
    );
  }
}
