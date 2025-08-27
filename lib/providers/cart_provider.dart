import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class CartProvider extends ChangeNotifier {
  final List<MenuItem> _items = [];

  List<MenuItem> get items => _items;

  double get totalPrice =>
      _items.fold(0, (total, current) => total + current.price);

  void addItem(MenuItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(MenuItem item) {
    _items.remove(item);
    notifyListeners();
  }
}