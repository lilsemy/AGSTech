import 'package:flutter/material.dart';

import 'dart:math';

import 'package:app_frontend/service/vehicle_service.dart';
import 'package:app_frontend/model/vehicle.dart';
import 'package:app_frontend/service/equipment_service.dart';
import 'package:app_frontend/model/equipment.dart';

class MyAppState extends ChangeNotifier {
  // User
  bool _isLoggedIn = false;
  bool _isEmployee = false;
  String _username = "";

  // Vehicles
  final VehicleService _vehicleService = VehicleService();
  List<Vehicle> _vehicles = [];
  Vehicle? _selectedVehicle;

  // Equipments
  final EquipmentService _equipmentService = EquipmentService();
  List<Equipment> _equipments = [];
  final List<int> _selectedEquipmentIds = [];

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

  Vehicle? get selectedVehicle {
    return _selectedVehicle;
  }

  List<Equipment> get equipments {
    return List.unmodifiable(_equipments);
  }

  List<int> get selectedEquipmentIds {
    return List.unmodifiable(_selectedEquipmentIds);
  }

  // Methods
  // User
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

  // Vehicles
  Future<void> loadVehicles() async {
    try {
      _vehicles = await _vehicleService.fetchVehicles(
        equipmentIds: _selectedEquipmentIds,
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> loadVehicleByVin(String vin) async {
    try {
      _selectedVehicle = await _vehicleService.fetchVehicleByVin(vin);
    } catch (e) {
      debugPrint(e.toString());
      _selectedVehicle = null;
    } finally {
      notifyListeners();
    }
  }

  // Equipments
  Future<void> loadEquipments() async {
    try {
      _equipments = await _equipmentService.fetchEquipments();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  void toggleEquipmentFilter(int equipmentId) {
    if (_selectedEquipmentIds.contains(equipmentId)) {
      _selectedEquipmentIds.remove(equipmentId);
    } else {
      _selectedEquipmentIds.add(equipmentId);
    }
    loadVehicles();
  }


  // Demo
  void assignCar() {
    car = cars[Random().nextInt(cars.length)];
    notifyListeners();
  }
}
