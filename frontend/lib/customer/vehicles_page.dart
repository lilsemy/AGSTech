import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_frontend/app_state.dart';
import 'package:app_frontend/customer/vehicle_details.dart';

class VehiclesPage extends StatefulWidget {
  const VehiclesPage({super.key});

  @override
  State<VehiclesPage> createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
  @override
  void initState() {
    super.initState();

    context.read<MyAppState>().loadVehicles();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fahrzeuge",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: ListView.builder(
        itemCount: appState.vehicles.length,
        itemBuilder: (context, index) {
          final vehicle = appState.vehicles[index];
          final imageUrl = vehicle.imageUrl;

          return ListTile(
            title: Text("${vehicle.brand} ${vehicle.model}"),
            subtitle: Text(vehicle.licensePlate),
            trailing: (imageUrl == null)
                ? Icon(Icons.image)
                : Image.network(imageUrl),
            minTileHeight: 100,
            onTap: () => Navigator.pushNamed(
              context,
              VehicleDetails.routeName,
              arguments: vehicle.vin,
            ),
          );
        },
      ),
    );
  }
}
