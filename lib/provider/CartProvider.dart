import 'package:flutter/material.dart';
import 'package:sushi_app/model/CartModel.dart';
import 'package:sushi_app/model/Sushi.dart';

class CartProvider extends ChangeNotifier {
  final List<CartModel> _cart = [];
  List<CartModel> get cart => _cart;

  void addToCart(Sushi sushiItem, int qty) {
    _cart.add(
      CartModel(
        name: sushiItem.name,
        price: sushiItem.price.toString(),
        imgPath: sushiItem.imgPath,
        quantity: qty.toString(),
      ),
    );
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  void removeItem(CartModel item) {
    _cart.remove(item);
    notifyListeners();
  }
}
