import '../repositories/reservation_repository.dart';

class CancelReservation {
  final ReservationRepository repository;

  CancelReservation(this.repository);

  Future<void> call(String id) async {
    return await repository.cancelReservation(id);
  }
}