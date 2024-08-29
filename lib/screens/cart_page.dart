import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart'; // Import the CartProvider
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    const branch = 'MALATE'; // Replace with the actual branch as needed
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.getCart(branch);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0c2344),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Cart', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color(0xFFFAF7E8),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
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
                for (var item in cartItems)
                  CartItem(
                    itemData: item,
                    onQuantityChanged: () {
                      cartProvider.notifyListeners(); // Notify provider for any changes
                    },
                    onRemove: () {
                      cartProvider.removeFromCart(branch, item);
                    },
                  ),
                OrderSummary(
                  subtotal: _calculateSubtotal(cartItems),
                  shipping: 100.0,
                  discount: 0.0,
                  total: _calculateTotal(cartItems),
                ),
              ],
            ),
          ),
          _buildStickyBottomBar(context),
        ],
      ),
    );
  }

  double _calculateSubtotal(List<CartItemData> cartItems) {
    return cartItems.fold(0, (sum, item) => sum + item.getTotalPrice());
  }

  double _calculateTotal(List<CartItemData> cartItems) {
    const double shipping = 100.0;
    const double discount = 0.0;
    return _calculateSubtotal(cartItems) + shipping - discount;
  }

  Widget _buildStickyBottomBar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(flex: 1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'TOTAL PRICE',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'P ${_calculateTotal(Provider.of<CartProvider>(context).getCart('MALATE')).toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Spacer(flex: 2),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CheckoutPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFffeead),
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text(
                'CHECK OUT',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final CartItemData itemData;
  final VoidCallback onQuantityChanged;
  final VoidCallback onRemove;

  const CartItem({
    super.key,
    required this.itemData,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.5, horizontal: 9.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black54, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF0c2344),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7.0),
                  bottomLeft: Radius.circular(7.0),
                ),
              ),
              width: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add, color: Color(0xFFffeead), size: 15),
                    onPressed: () {
                      itemData.quantity++;
                      onQuantityChanged();
                    },
                    splashColor: Colors.white24,
                    splashRadius: 20.0,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  Text('${itemData.quantity}', style: const TextStyle(color: Colors.white, fontSize: 14)),
                  IconButton(
                    icon: const Icon(Icons.remove, color: Color(0xFFffeead), size: 15),
                    onPressed: () {
                      if (itemData.quantity > 1) {
                        itemData.quantity--;
                        onQuantityChanged();
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
                        color: const Color(0xFFffeead),
                        border: Border.all(color: Colors.black54, width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(itemData.imagePath, fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            itemData.titleLine1,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            itemData.titleLine2,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'HANWOO GIFT BOX',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Text(
                            itemData.weight,
                            style: const TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'P ${itemData.price.toStringAsFixed(2)}',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                      onPressed: onRemove,
                      splashColor: Colors.white24,
                      splashRadius: 20.0,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
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

class OrderSummary extends StatelessWidget {
  final double subtotal;
  final double shipping;
  final double discount;
  final double total;

  const OrderSummary({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.discount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black54, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow('Subtotal', subtotal),
          _buildSummaryRow('Shipping', shipping),
          _buildSummaryRow('Discount', discount),
          _buildSummaryRow('Total', total, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            'P ${value.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
