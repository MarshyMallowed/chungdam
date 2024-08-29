import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, List<CartItemData>> _carts = {
    'MALATE': [],
    'PARQAL': [],
    'BGC': [],
  };

  List<CartItemData> getCart(String branch) {
    return _carts[branch] ?? [];
  }

  void addToCart(String branch, CartItemData item) {
    if (_carts.containsKey(branch)) {
      final cart = _carts[branch]!;
      final existingItemIndex = cart.indexWhere((cartItem) => cartItem == item);
      if (existingItemIndex >= 0) {
        // Update quantity if item already exists
        cart[existingItemIndex].quantity += item.quantity;
      } else {
        // Add new item to cart
        cart.add(item);
      }
      notifyListeners();
    }
  }

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
}

class CartItemData {
  final String titleLine1;
  final String titleLine2;
  final double price;
  final String imagePath;
  final String weight;
  int quantity;

  CartItemData({
    required this.titleLine1,
    required this.titleLine2,
    required this.price,
    required this.imagePath,
    required this.weight,
    this.quantity = 1,
  });

  double getTotalPrice() => price * quantity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemData &&
          runtimeType == other.runtimeType &&
          titleLine1 == other.titleLine1 &&
          titleLine2 == other.titleLine2 &&
          price == other.price &&
          imagePath == other.imagePath &&
          weight == other.weight;

  @override
  int get hashCode =>
      titleLine1.hashCode ^
      titleLine2.hashCode ^
      price.hashCode ^
      imagePath.hashCode ^
      weight.hashCode;
}
