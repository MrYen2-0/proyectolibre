import '../../domain/entities/facility.dart';

class FacilityModel extends Facility {
  const FacilityModel({
    required super.id,
    required super.name,
    required super.type,
    required super.description,
    required super.capacity,
  });

  factory FacilityModel.fromJson(Map<String, dynamic> json) {
    return FacilityModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      description: json['description'],
      capacity: json['capacity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'description': description,
      'capacity': capacity,
    };
  }
}