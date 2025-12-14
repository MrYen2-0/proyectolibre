import 'package:flutter/material.dart';
import '../../domain/entities/facility.dart';
import '../../domain/usecases/get_facilities.dart';

class FacilityProvider with ChangeNotifier {
  final GetFacilities getFacilities;

  FacilityProvider({required this.getFacilities});

  List<Facility> _facilities = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Facility> get facilities => _facilities;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadFacilities() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _facilities = await getFacilities();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Facility> getFacilitiesByType(String type) {
    return _facilities.where((f) => f.type == type).toList();
  }
}