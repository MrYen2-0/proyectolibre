import '../entities/facility.dart';
import '../repositories/facility_repository.dart';

class GetFacilities {
  final FacilityRepository repository;

  GetFacilities(this.repository);

  Future<List<Facility>> call() async {
    return await repository.getFacilities();
  }
}