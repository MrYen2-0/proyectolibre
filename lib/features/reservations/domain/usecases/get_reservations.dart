import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class GetReservations {
  final ReservationRepository repository;

  GetReservations(this.repository);

  Future<List<Reservation>> call() async {
    return await repository.getReservations();
  }
}