import '../models/m01apli/m01apli_model.dart';
import '../services/m01apli_api_service.dart';

class M01APliRepository {
  final M01APliApiService _apiService;

  M01APliRepository(this._apiService);

  Future<List<M01APli>> fetchM01APlis() async {
    return await _apiService.getM01APlis();
  }

  Future<M01APli> createM01APli(M01APli pli) async {
    return await _apiService.createM01APli(pli);
  }

  Future<M01APli> updateM01APli(M01APli pli) async {
    return await _apiService.updateM01APli(pli);
  }

  Future<void> deleteM01APli(String idphieu) async {
    return await _apiService.deleteM01APli(idphieu);
  }
}
