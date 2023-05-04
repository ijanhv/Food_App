import 'package:flutter/material.dart';

class BagItem {
  final String name;
  final double price;

  BagItem({required this.name, required this.price});
}

class BagProvider extends ChangeNotifier {
  List<BagItem> bagItems = [];

  void addToBag(String name, double price) {
    final item = BagItem(name: name, price: price);
    bagItems.add(item);
    notifyListeners();
  }

  void removeFromBag(String name) {
    bagItems.removeWhere((item) => item.name == name);
    notifyListeners();
  }
}
