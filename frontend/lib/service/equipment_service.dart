import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:app_frontend/model/equipment.dart';

class EquipmentService {
  //Learning: Unterstrich am Anfang von einer Variable macht sie private
  final String _apiUrl = 'http://localhost:8080/api/equipments';

  Future<List<Equipment>> fetchEquipments() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      List<Equipment> equipments = [];

      for (var element in data) {
        equipments.add(Equipment.fromJson(element));
      }
      return equipments;
    }
    throw Exception(
      "Equipments konnten nicht geladen werden. Status: ${response.statusCode}",
    );
  }
}