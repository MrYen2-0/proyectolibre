import '../../domain/entities/facility.dart';
import '../../domain/repositories/facility_repository.dart';
import '../datasources/facility_local_datasource.dart';

class FacilityRepositoryImpl implements FacilityRepository {
  final FacilityLocalDataSource localDataSource;

  FacilityRepositoryImpl(this.localDataSource);

  @override
  Future<List<Facility>> getFacilities() async {
    return await localDataSource.getFacilities();
  }
}