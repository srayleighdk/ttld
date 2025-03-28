import '../models/m01pli/m01pli_model.dart';
import '../services/m01pli_api_service.dart';

class M01PliRepository {
  final M01PliApiService _apiService;

  M01PliRepository(this._apiService);

  Future<Map<String, dynamic>> fetchM01Plis({int page = 1, int limit = 10}) async {
    return await _apiService.getM01Plis(page: page, limit: limit);
  }

  Future<M01Pli> createM01Pli(M01Pli pli) async {
    return await _apiService.createM01Pli(pli);
  }

  Future<M01Pli> updateM01Pli(M01Pli pli) async {
    return await _apiService.updateM01Pli(pli);
  }

  Future<void> deleteM01Pli(String idphieu) async {
    return await _apiService.deleteM01Pli(idphieu);
  }
}
