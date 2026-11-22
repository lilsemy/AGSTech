import 'package:flutter/material.dart';

import 'dart:math';

import 'package:app_frontend/service/vehicle_service.dart';
import 'package:app_frontend/model/vehicle.dart';

class MyAppState extends ChangeNotifier {
  // User
  bool _isLoggedIn = false;
  bool _isEmployee = false;
  String _username = "";

  // Vehicles
  final VehicleService _vehicleservice = VehicleService();
  List<Vehicle> _vehicles = [];

  // Demo
  final cars = ["Audi", "BMW", "Volvo", "Mercedes"];
  String car = "Audi";

  // Getter
  bool get isLoggedIn {
    return _isLoggedIn;
  }

  bool get isEmployee {
    return _isEmployee;
  }

  String get username {
    return _username;
  }

  List<Vehicle> get vehicles {
    return List.unmodifiable(_vehicles);
  }

  // Methods
  void login(String user) {
    if (user.trim().isNotEmpty) {
      _username = user.trim();
      _isLoggedIn = true;
      notifyListeners();
    }
  }

  void logout() {
    _isLoggedIn = false;
    _username = "";
    notifyListeners();
  }

  void assignCar() {
    car = cars[Random().nextInt(cars.length)];
    notifyListeners();
  }

  Future<void> loadVehicles() async {
    try {
      _vehicles = await _vehicleservice.fetchVehicles();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
