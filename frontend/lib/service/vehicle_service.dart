import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:app_frontend/model/vehicle.dart';

class VehicleService {
  static const String apiUrl = "http://localhost:8080/api/vehicles";

Future<List<Vehicle>> fetchVehicles({List<int>? equipmentIds}) async {
    String url = apiUrl;
    //Check, ob equipments ausgewählt wurden -> Wenn ja, umbau der URL, sodass die equipment IDs mitgegeben werden
    if (equipmentIds != null && equipmentIds.isNotEmpty) {
      url = "$apiUrl?equipments=${equipmentIds.join(',')}";
    }

    final response = await http.get(Uri.parse(url));
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

  Future<Vehicle> fetchVehicleByVin(String vin) async {
    final response = await http.get(Uri.parse("$apiUrl/$vin"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      Vehicle vehicle = Vehicle.fromJson(data);
      return vehicle;
    } else if (response.statusCode == 404) {
      throw Exception(
        "Fahrzeug ${vin} wurde nicht gefunden. Status: ${response.statusCode}",
      );
    } else {
      throw Exception(
        "Fahrzeug ${vin} konnte nicht geladen werden. Status: ${response.statusCode}",
      );
    }
  }
}
