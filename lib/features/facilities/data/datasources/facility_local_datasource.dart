import '../../../../core/constants/app_constants.dart';
import '../models/facility_model.dart';

abstract class FacilityLocalDataSource {
  Future<List<FacilityModel>> getFacilities();
}

class FacilityLocalDataSourceImpl implements FacilityLocalDataSource {
  @override
  Future<List<FacilityModel>> getFacilities() async {
    // Simulando datos locales de salones para eventos
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      const FacilityModel(
        id: '1',
        name: 'Salón Imperial',
        type: AppConstants.ballroomType,
        description: '',
        capacity: 300,
      ),
      const FacilityModel(
        id: '2',
        name: 'Salón Ejecutivo Premium',
        type: AppConstants.conferenceType,
        description: '',
        capacity: 150,
      ),
      const FacilityModel(
        id: '3',
        name: 'Gran Salón de Banquetes',
        type: AppConstants.banquetType,
        description: '',
        capacity: 400,
      ),
      const FacilityModel(
        id: '4',
        name: 'Salón Crystal',
        type: AppConstants.ballroomType,
        description: '',
        capacity: 250,
      ),
      const FacilityModel(
        id: '5',
        name: 'Auditorio Corporativo',
        type: AppConstants.conferenceType,
        description: '',
        capacity: 200,
      ),
      const FacilityModel(
        id: '6',
        name: 'Terraza Jardín',
        type: AppConstants.banquetType,
        description: '',
        capacity: 180,
      ),
      const FacilityModel(
        id: '7',
        name: 'Salón Venecia',
        type: AppConstants.ballroomType,
        description: '',
        capacity: 220,
      ),
      const FacilityModel(
        id: '8',
        name: 'Centro de Convenciones',
        type: AppConstants.conferenceType,
        description: '',
        capacity: 500,
      ),
    ];
  }
}