class Equipment {
  final int equipmentId;
  final String name;
  final String? description;

  Equipment({
    required this.equipmentId,
    required this.name,
    this.description,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      equipmentId: json['equipmentId'],
      name: json['name'],
      description: json['description'],
    );
  }
}