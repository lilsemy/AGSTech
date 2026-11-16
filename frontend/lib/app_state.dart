import 'package:flutter/material.dart';

import 'dart:math';

class MyAppState extends ChangeNotifier {
  bool isLoggedIn = false;
  bool isEmployee = false;
  String username = "";

  void login(String user) {
    if (user.trim().isNotEmpty) {
      username = user.trim();
      isLoggedIn = true;
      notifyListeners();
    }
  }

  void logout() {
    isLoggedIn = false;
    username = '';
    notifyListeners();
  }

  final cars = ["Audi", "BMW", "Volvo", "Mercedes"];

  String car = "Audi";

  void assignCar() {
    car = cars[Random().nextInt(cars.length)];
    notifyListeners();
  }

  var favorites = <String>[];

  void toggleFavorite() {
    if (favorites.contains(car)) {
      favorites.remove(car);
    } else {
      favorites.add(car);
    }
    notifyListeners();
  }
}
