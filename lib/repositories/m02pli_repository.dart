import '../models/m02pli/m02pli_model.dart';
import '../services/m02pli_api_service.dart';

class M02PliRepository {
  final M02PliApiService _apiService;

  M02PliRepository(this._apiService);

  Future<List<M02Pli>> fetchM02Plis() async {
    return await _apiService.getM02Plis();
  }

  Future<M02Pli> createM02Pli(M02Pli pli) async {
    return await _apiService.createM02Pli(pli);
  }

  Future<M02Pli> updateM02Pli(M02Pli pli) async {
    return await _apiService.updateM02Pli(pli);
  }

  Future<void> deleteM02Pli(String idphieu) async {
    return await _apiService.deleteM02Pli(idphieu);
  }
}
