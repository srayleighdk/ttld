
import 'package:ttld/core/services/tt_tantat_api_service.dart';
import 'package:ttld/models/tttantat/tttantat.dart';
import 'package:ttld/repositories/tt_tantat/tt_tantat_repository.dart';

class TtTantatRepositoryImpl implements TtTantatRepository {
  final TTTanTatApiService _apiService;

  TtTantatRepositoryImpl(this._apiService);

  @override
  Future<List<TtTantat>> getTtTantat() async {
    final response = await _apiService.getTTTanTat();
    final data = response.data['data'] as List;
    return data.map((json) => TtTantat.fromJson(json)).toList();
  }
}
