import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class CreateReservation {
  final ReservationRepository repository;

  CreateReservation(this.repository);

  Future<void> call(Reservation reservation) async {
    return await repository.createReservation(reservation);
  }
}