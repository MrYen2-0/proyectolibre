import '../../domain/entities/reservation.dart';
import '../../domain/repositories/reservation_repository.dart';
import '../datasources/reservation_local_datasource.dart';
import '../models/reservation_model.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  final ReservationLocalDataSource localDataSource;

  ReservationRepositoryImpl(this.localDataSource);

  @override
  Future<List<Reservation>> getReservations() async {
    return await localDataSource.getReservations();
  }

  @override
  Future<void> createReservation(Reservation reservation) async {
    final reservations = await localDataSource.getReservations();
    reservations.add(ReservationModel.fromEntity(reservation));
    await localDataSource.saveReservations(reservations);
  }

  @override
  Future<void> cancelReservation(String id) async {
    final reservations = await localDataSource.getReservations();
    final index = reservations.indexWhere((r) => r.id == id);
    if (index != -1) {
      final updated = ReservationModel(
        id: reservations[index].id,
        facilityId: reservations[index].facilityId,
        facilityName: reservations[index].facilityName,
        facilityType: reservations[index].facilityType,
        date: reservations[index].date,
        timeSlot: reservations[index].timeSlot,
        userName: reservations[index].userName,
        status: 'cancelled',
      );
      reservations[index] = updated;
      await localDataSource.saveReservations(reservations);
    }
  }
}