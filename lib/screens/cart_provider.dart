import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, List<CartItemData>> _carts = {
    'MALATE': [],
    'PARQAL': [],
    'BGC': [],
  };

  // Retrieves the cart items for the specified branch
  List<CartItemData> getCart(String branch) {
    return _carts[branch] ?? [];
  }

  // Adds an item to the cart for the specified branch
  void addToCart(String branch, CartItemData item) {
    if (_carts.containsKey(branch)) {
      final cart = _carts[branch]!;
      final existingItemIndex = cart.indexWhere((cartItem) => cartItem == item);
      if (existingItemIndex >= 0) {
        // Update quantity if item already exists
        cart[existingItemIndex].quantity += item.quantity;
        if (cart[existingItemIndex].quantity <= 0) {
          cart.removeAt(existingItemIndex);
        }
      } else {
        // Add new item to cart
        cart.add(item);
      }
      notifyListeners();
    }
  }

  // Removes an item from the cart for the specified branch
  void removeFromCart(String branch, CartItemData item) {
    if (_carts.containsKey(branch)) {
      final cart = _carts[branch]!;
      final existingItemIndex = cart.indexWhere((cartItem) => cartItem == item);
      if (existingItemIndex >= 0) {
        cart.removeAt(existingItemIndex);
        notifyListeners();
      }
    }
  }

  // Clears all items from the cart for the specified branch
  void clearCart(String branch) {
    if (_carts.containsKey(branch)) {
      _carts[branch]!.clear();
      notifyListeners();
    }
  }
}

class CartItemData {
  final String itemId;
  final String itemCartImage;
  final String itemName; // Original item name
  int price; // Kept as String
  int weight;
  int quantity;
  late String titleLine1; // New field for the first line of the title
  late String titleLine2; // New field for the second line of the title

  CartItemData({
    required this.itemId,
    required this.itemCartImage,
    required this.itemName,
    required this.price,
    required this.weight,
    this.quantity = 1,
  }) {
    // Manually separate itemName into titleLine1 and titleLine2
    List<String> titleParts = itemName.split('|'); // Assuming '|' is the delimiter
    titleLine1 = titleParts.isNotEmpty ? titleParts[0] : '';
    titleLine2 = titleParts.length > 1 ? titleParts[1] : '';
  }

  // Convert price from String to double and calculate total price
  int getTotalPrice() {
    return (price  * quantity);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemData &&
          runtimeType == other.runtimeType &&
          itemId == other.itemId &&
          itemName == other.itemName &&
          price == other.price;

  @override
  int get hashCode =>
      itemId.hashCode ^ itemName.hashCode ^ price.hashCode;

  @override
  String toString() {
    return 'CartItemData(itemId: $itemId, itemName: $itemName, price: $price, quantity: $quantity)';
  }
}

