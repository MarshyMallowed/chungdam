import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0c2344), // Dark blue color
        iconTheme: const IconThemeData(color: Colors.white), // Set the icon color to white
        title: const Text('Cart', style: TextStyle(color: Colors.white)), // Set title color to white if needed
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Use the arrow back icon
          onPressed: () => Navigator.pop(context),
          color: Colors.white, // Set the arrow back button color to white
        ),
      ),
      backgroundColor: const Color(0xFFFAF7E8),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Cart',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                CartItem(
                  titleLine1: "HANWOO PRIME",
                  titleLine2: "RIBEYE",
                  price: "2800",
                  imagePath: 'assets/hanwoo_ribeye.png',
                  weight: "150g",
                ),
                CartItem(
                  titleLine1: "HANWOO OUTSIDE",
                  titleLine2: "SKIRT MEAT",
                  price: "2500",
                  imagePath: 'assets/hanwoo_skirt.png',
                  weight: "100g",
                ),
                CartItem(
                  titleLine1: "HANWOO",
                  titleLine2: "TENDERLOIN",
                  price: "2800",
                  imagePath: 'assets/hanwoo_tenderloin.png',
                  weight: "150g",
                ),
                OrderSummary(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem extends StatefulWidget {
  final String titleLine1;
  final String titleLine2;
  final String price;
  final String imagePath;
  final String weight;

  const CartItem({
    Key? key,
    required this.titleLine1,
    required this.titleLine2,
    required this.price,
    required this.imagePath,
    required this.weight,
  }) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.5, horizontal: 9.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black54, width: 1.0),
        borderRadius: BorderRadius.circular(8.0), // Rounded edges
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF0c2344),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7.0), // Consistent rounded edges
                  bottomLeft: Radius.circular(7.0), // Consistent rounded edges
                ),
              ),
              width: 40, // Increased width
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add, color: Color(0xFFbc9c22), size: 15), // Larger icon
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    splashColor: Colors.white24,
                    splashRadius: 20.0,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  Text('$quantity', style: const TextStyle(color: Colors.white, fontSize: 14)),
                  IconButton(
                    icon: const Icon(Icons.remove, color: Color(0xFFbc9c22), size: 15), // Larger icon
                    onPressed: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                    splashColor: Colors.white24,
                    splashRadius: 20.0,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                child: Row(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xFFfff6cd),
                        border: Border.all(color: Colors.black54, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0), // Rounded edges
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(widget.imagePath, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.titleLine1,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.titleLine2,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'HANWOO ALA CARTE',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'P ${widget.price}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '/${widget.weight}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 40, // Increased width
              height: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF0c2344),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(7.0), // Consistent rounded edges
                  bottomRight: Radius.circular(7.0), // Consistent rounded edges
                ),
              ),
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Color(0xFFFAF7E8), size: 20), // Larger icon
                  onPressed: () {
                    // Handle item removal logic
                  },
                  splashColor: Colors.white24,
                  splashRadius: 20.0,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  const OrderSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 9.0),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(8.0), // Consistent rounded edges
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVoucherBar(context),
              const SizedBox(height: 20), // Reduced space
              const Text(
                'Order Summary',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8), // Reduced space
              _buildSummaryItem('Subtotal', 'P 8100.00', containerHeight: 35),
              _buildSummaryItem('Shipping', 'P 100.00', containerHeight: 35),
              _buildSummaryItem('Discount', 'P 0.00', containerHeight: 55),
              _buildSummaryItem('Total', 'P 8200.00', containerHeight: 35, isTotal: true),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100.0),
          child: ElevatedButton(
            onPressed: () {
              // Navigate to the Checkout Page
              Navigator.pushNamed(context, '/checkout');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFfff6cd),
              minimumSize: const Size.fromHeight(45),
              side: const BorderSide(color: Colors.black, width: 2), // Thick outline border
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(150.0), // Rounded edges
              ),
            ),
            child: const Text(
              'CHECK OUT',
              style: TextStyle(color: Colors.black, letterSpacing: 1.2), // Capitalized and black
            ),
          ),
        ),
        const SizedBox(height: 50), // Added space below the "CHECK OUT" button
      ],
    );
  }

  Widget _buildVoucherBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/vouchers'); // Navigate to VouchersPage
      },
      child: Container(
        height: 40, // Reduced height
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          color: const Color(0xFFfff6cd),
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(8.0), // Consistent rounded edges
        ),
        child: Row(
          children: [
            const Icon(Icons.card_giftcard, color: Colors.black54, size: 20),
            const SizedBox(width: 8),
            const Text(
              'Vouchers',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Colors.black54, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, {bool isTotal = false, double containerHeight = 30}) {
    return Container(
      height: containerHeight, // Customizable height for summary items
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
