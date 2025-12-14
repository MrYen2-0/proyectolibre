import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/reservations/data/datasources/reservation_local_datasource.dart';
import 'features/reservations/data/repositories/reservation_repository_impl.dart';
import 'features/reservations/domain/repositories/reservation_repository.dart';
import 'features/reservations/domain/usecases/create_reservation.dart';
import 'features/reservations/domain/usecases/get_reservations.dart';
import 'features/reservations/domain/usecases/cancel_reservation.dart';
import 'features/reservations/presentation/providers/reservation_provider.dart';
import 'features/facilities/data/datasources/facility_local_datasource.dart';
import 'features/facilities/data/repositories/facility_repository_impl.dart';
import 'features/facilities/domain/repositories/facility_repository.dart';
import 'features/facilities/domain/usecases/get_facilities.dart';
import 'features/facilities/presentation/providers/facility_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Data sources
  sl.registerLazySingleton<ReservationLocalDataSource>(
        () => ReservationLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<FacilityLocalDataSource>(
        () => FacilityLocalDataSourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<ReservationRepository>(
        () => ReservationRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<FacilityRepository>(
        () => FacilityRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => CreateReservation(sl()));
  sl.registerLazySingleton(() => GetReservations(sl()));
  sl.registerLazySingleton(() => CancelReservation(sl()));
  sl.registerLazySingleton(() => GetFacilities(sl()));

  // Providers
  sl.registerFactory(
        () => ReservationProvider(
      createReservation: sl(),
      getReservations: sl(),
      cancelReservation: sl(),
    ),
  );
  sl.registerFactory(
        () => FacilityProvider(getFacilities: sl()),
  );
}