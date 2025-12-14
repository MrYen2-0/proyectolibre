import '../entities/reservation.dart';

abstract class ReservationRepository {
  Future<List<Reservation>> getReservations();
  Future<void> createReservation(Reservation reservation);
  Future<void> cancelReservation(String id);
}