class Vehicle {
  final String vin;
  final String licensePlate;
  final int mileage;
  final String brand;
  final String model;
  final String vehicleClass;
  final String fuelType;
  final int seats;
  final int? trunkCapacity;
  final String? imageUrl;
  final String? status;
  final double dailyPrice;
  final String? color;
  final int? power;
  final String transmission;
  final String driveType;
  final DateTime inspectionExpiryDate;
  final int? locationId;

  Vehicle({
    required this.vin,
    required this.licensePlate,
    required this.mileage,
    required this.brand,
    required this.model,
    required this.vehicleClass,
    required this.fuelType,
    required this.seats,
    this.trunkCapacity,
    this.imageUrl,
    this.status,
    required this.dailyPrice,
    this.color,
    this.power,
    required this.transmission,
    required this.driveType,
    required this.inspectionExpiryDate,
    this.locationId,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      vin: json['vin'],
      licensePlate: json['licensePlate'],
      mileage: json['mileage'],
      brand: json['brand'],
      model: json['model'],
      vehicleClass: json['vehicleClass'],
      fuelType: json['fuelType'],
      seats: json['seats'],
      trunkCapacity: json['trunkCapacity'],
      imageUrl: json['imageUrl'],
      status: json['status'],
      dailyPrice: (json['dailyPrice'] as num).toDouble(),
      color: json['color'],
      power: json['power'],
      transmission: json['transmission'],
      driveType: json['driveType'],
      inspectionExpiryDate: DateTime.parse(json['inspectionExpiryDate']),
      locationId: json['locationId'],
    );
  }
}
