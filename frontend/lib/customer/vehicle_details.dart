import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_frontend/app_state.dart';

class VehicleDetails extends StatefulWidget {
  static const routeName = '/vehicle-details';
  final String vin;

  VehicleDetails({super.key, required this.vin});

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  @override
  void initState() {
    super.initState();

    context.read<MyAppState>().loadVehicleByVin(widget.vin);
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    final vehicle = appState.selectedVehicle;

    if (vehicle == null) {
      return Scaffold(
        body: Center(child: Column(children: [CircularProgressIndicator()])),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${vehicle.brand} ${vehicle.model}",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              vehicle.imageUrl == null
                  ? Icon(Icons.image)
                  : Image.network(vehicle.imageUrl!),
              Text("VIN: ${vehicle.vin}"),
              Text("License plate: ${vehicle.licensePlate}"),
              Text("Mileage: ${vehicle.mileage}"),
              Text("Brand: ${vehicle.brand}"),
              Text("Vehicle Class: ${vehicle.vehicleClass}"),
              Text("Fuel type: ${vehicle.fuelType}"),
              Text("Seats: ${vehicle.seats}"),
              Text("Trunk capacity: ${vehicle.trunkCapacity}"),
              Text("VIN: ${vehicle.imageUrl}"),
              Text("Status: ${vehicle.status}"),
              Text("Daily price: ${vehicle.dailyPrice}"),
              Text("Color: ${vehicle.color}"),
              Text("Power: ${vehicle.power}"),
              Text("Transmission: ${vehicle.transmission}"),
              Text("Drive type: ${vehicle.driveType}"),
              Text("Inspection expiry date: ${vehicle.inspectionExpiryDate}"),
              Text("Location: ${vehicle.locationId}"),
            ],
          ),
        ),
      ),
    );
  }
}
