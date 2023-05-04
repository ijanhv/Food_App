import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? fullName;
  String? email;
  String? id;
  String? address;

  void setUserFullName(String name) {
    fullName = name;
    notifyListeners();
  }

  void setUserEmail(String userEmail) {
    email = userEmail;
    notifyListeners();
  }

  void setUserId(String userId) {
    id = userId;
    notifyListeners();
  }

  void setUserAddress(String address) {
    address = address;
    notifyListeners();
  }
}
