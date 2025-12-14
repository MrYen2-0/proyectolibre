import '../../domain/entities/reservation.dart';

class ReservationModel extends Reservation {
  const ReservationModel({
    required super.id,
    required super.facilityId,
    required super.facilityName,
    required super.facilityType,
    required super.date,
    required super.timeSlot,
    required super.userName,
    required super.status,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      facilityId: json['facilityId'],
      facilityName: json['facilityName'],
      facilityType: json['facilityType'],
      date: DateTime.parse(json['date']),
      timeSlot: json['timeSlot'],
      userName: json['userName'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'facilityId': facilityId,
      'facilityName': facilityName,
      'facilityType': facilityType,
      'date': date.toIso8601String(),
      'timeSlot': timeSlot,
      'userName': userName,
      'status': status,
    };
  }

  factory ReservationModel.fromEntity(Reservation reservation) {
    return ReservationModel(
      id: reservation.id,
      facilityId: reservation.facilityId,
      facilityName: reservation.facilityName,
      facilityType: reservation.facilityType,
      date: reservation.date,
      timeSlot: reservation.timeSlot,
      userName: reservation.userName,
      status: reservation.status,
    );
  }
}