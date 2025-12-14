import '../entities/facility.dart';

abstract class FacilityRepository {
  Future<List<Facility>> getFacilities();
}