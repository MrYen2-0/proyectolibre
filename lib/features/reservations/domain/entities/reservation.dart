import 'package:equatable/equatable.dart';

class Reservation extends Equatable {
  final String id;
  final String facilityId;
  final String facilityName;
  final String facilityType;
  final DateTime date;
  final String timeSlot;
  final String userName;
  final String status; // 'active', 'cancelled'

  const Reservation({
    required this.id,
    required this.facilityId,
    required this.facilityName,
    required this.facilityType,
    required this.date,
    required this.timeSlot,
    required this.userName,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    facilityId,
    facilityName,
    facilityType,
    date,
    timeSlot,
    userName,
    status,
  ];
}