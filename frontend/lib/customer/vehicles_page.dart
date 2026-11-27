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

    context.read<MyAppState>().loadEquipments();
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
      body: Column(
        children: [
          //ExpansionTile ist perfekt zum späteren hinzufügen von Preis, Standort etc.
          ExpansionTile(
            leading: const Icon(Icons.filter_list),
            title: const Text("Filter"),
            subtitle: Text(
              appState.selectedEquipmentIds.isEmpty
                  ? "Keine Filter aktiv"
                  : "${appState.selectedEquipmentIds.length} ausgewählt",
            ),
            childrenPadding: const EdgeInsets.all(12.0),
            children: [
              if (appState.equipments.isEmpty)
                const Text("Keine Equipments geladen")
              else
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: appState.equipments.map((eq) {
                    final isSelected = appState.selectedEquipmentIds
                        .contains(eq.equipmentId);
                    return FilterChip(
                      label: Text(eq.name),
                      selected: isSelected,
                      onSelected: (_) =>
                          appState.toggleEquipmentFilter(eq.equipmentId),
                    );
                  }).toList(),
                ),
              // Platz für zukünftige Filter (z. B. Preis, Standort)
            ],
          ),
          //Expanded checkt, wie viel Platz es noch hat, wenn das ExpansionTile auf- bzw. zugeklappt ist
          Expanded(
            child: ListView.builder(
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
          ),
        ],
      ),
    );
  }
}
