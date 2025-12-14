import 'package:equatable/equatable.dart';

class Facility extends Equatable {
  final String id;
  final String name;
  final String type;
  final String description;
  final int capacity;

  const Facility({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.capacity,
  });

  @override
  List<Object?> get props => [id, name, type, description, capacity];
}