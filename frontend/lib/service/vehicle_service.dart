import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:app_frontend/model/vehicle.dart';

class VehicleService {
  static const String apiUrl = "http://localhost:8080/api/vehicles";

  Future<List<Vehicle>> fetchVehicles() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(
        response.body,
      ); // turn String into List with arbitrary Dart objects

      List<Vehicle> vehicles = [];

      for (var element in data) {
        vehicles.add(Vehicle.fromJson(element));
      }
      return vehicles;
    }
    throw Exception(
      "Fahrzeuge konnten nicht geladen werden. Status: ${response.statusCode}",
    );
  }
}
