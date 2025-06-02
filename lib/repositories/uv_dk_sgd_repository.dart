import 'package:ttld/core/services/uv_dk_sgd_api_service.dart';
import 'package:ttld/models/uv_dk_sgd/uv_dk_sgd_model.dart';

abstract class UvDkSGDRepository {
  Future<List<UvDkSGD>> getUvDkSGDs(String userId);
}

class UvDkSGDRepositoryImpl implements UvDkSGDRepository {
  final UvDkSGDApiService _apiService;

  UvDkSGDRepositoryImpl(this._apiService);

  @override
  Future<List<UvDkSGD>> getUvDkSGDs(String userId) async {
    try {
      final response = await _apiService.getUvDkSGDs(userId);
      return response;
      
      
      throw Exception('Response does not contain data field');
    } catch (e) {
      print('Error details: $e');
      throw Exception('Failed to load UvDkSGD data: $e');
    }
  }
} 