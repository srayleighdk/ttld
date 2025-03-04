import 'package:ttld/core/services/m03pli_api_service.dart';
import 'package:ttld/models/m03pli_model.dart';

class M03PLIRepository {
  final M03PLIApiService _m03pliApiService;

  M03PLIRepository(this._m03pliApiService);

  Future<List<M03PLIModel>> getM03PLIs() async {
    return _m03pliApiService.getM03PLIs();
  }

  Future<M03PLIModel> createM03PLI(M03PLIModel m03pli) async {
    return _m03pliApiService.createM03PLI(m03pli);
  }

  Future<M03PLIModel> updateM03PLI(M03PLIModel m03pli) async {
    return _m03pliApiService.updateM03PLI(m03pli);
  }

  Future<void> deleteM03PLI(String id) async {
    return _m03pliApiService.deleteM03PLI(id);
  }
}
