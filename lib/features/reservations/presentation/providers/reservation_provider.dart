import 'package:flutter/material.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/usecases/create_reservation.dart';
import '../../domain/usecases/get_reservations.dart';
import '../../domain/usecases/cancel_reservation.dart';

class ReservationProvider with ChangeNotifier {
  final CreateReservation createReservation;
  final GetReservations getReservations;
  final CancelReservation cancelReservation;

  ReservationProvider({
    required this.createReservation,
    required this.getReservations,
    required this.cancelReservation,
  });

  List<Reservation> _reservations = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Reservation> get reservations => _reservations;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<Reservation> get activeReservations =>
      _reservations.where((r) => r.status == 'active').toList();

  Future<void> loadReservations() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _reservations = await getReservations();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addReservation(Reservation reservation) async {
    try {
      await createReservation(reservation);
      await loadReservations();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> cancelReservationById(String id) async {
    try {
      await cancelReservation(id);
      await loadReservations();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}