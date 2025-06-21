import 'package:ttld/core/services/uv_dk_sgd_api_service.dart';
import 'package:ttld/models/uv_dk_sgd/uv_dk_sgd_model.dart';

abstract class UvDkSGDRepository {
  Future<List<UvDkSGD>> getUvDkSGDs(String userId);
  Future<UvDkSGD> registerForSGDVL(UvDkSGD registration);
}

class UvDkSGDRepositoryImpl implements UvDkSGDRepository {
  final UvDkSGDApiService _apiService;

  UvDkSGDRepositoryImpl(this._apiService);

  @override
  Future<List<UvDkSGD>> getUvDkSGDs(String userId) async {
    try {
      return await _apiService.getUvDkSGDs(userId);
    } catch (e) {
      throw Exception('Failed to load UvDkSGD data: $e');
    }
  }

  @override
  Future<UvDkSGD> registerForSGDVL(UvDkSGD registration) async {
    try {
      return await _apiService.registerForSGDVL(registration);
    } catch (e) {
      throw Exception('Failed to register for SGDVL: $e');
    }
  }
} 