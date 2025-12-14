import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/reservation_model.dart';

abstract class ReservationLocalDataSource {
  Future<List<ReservationModel>> getReservations();
  Future<void> saveReservations(List<ReservationModel> reservations);
}

class ReservationLocalDataSourceImpl implements ReservationLocalDataSource {
  final SharedPreferences sharedPreferences;

  ReservationLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<ReservationModel>> getReservations() async {
    final jsonString = sharedPreferences.getString(AppConstants.reservationsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => ReservationModel.fromJson(json)).toList();
    }
    return [];
  }

  @override
  Future<void> saveReservations(List<ReservationModel> reservations) async {
    final jsonList = reservations.map((r) => r.toJson()).toList();
    await sharedPreferences.setString(
      AppConstants.reservationsKey,
      json.encode(jsonList),
    );
  }
}