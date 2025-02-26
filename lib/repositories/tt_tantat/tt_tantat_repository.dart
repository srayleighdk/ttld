import 'package:ttld/core/services/tt_tantat_api_service.dart';
import 'package:ttld/models/tttantat/tttantat.dart';

abstract class TTTanTatRepository {
  Future<List<TTTanTat>> getTTTanTats();
  Future<TTTanTat> addTTTanTat(TTTanTat ttTanTat);
  Future<TTTanTat> updateTTTanTat(TTTanTat ttTanTat);
  Future<void> deleteTTTanTat(String id);
}

class TTTanTatRepositoryImpl implements TTTanTatRepository {
  final TTTanTatApiService ttTanTatApiService;

  TTTanTatRepositoryImpl({required this.ttTanTatApiService});

  @override
  Future<List<TTTanTat>> getTTTanTats() async {
    final response = await ttTanTatApiService.getTTTanTat();
    return (response.data['data'] as List)
        .map((json) => TTTanTat.fromJson(json))
        .toList();
  }

  @override
  Future<TTTanTat> addTTTanTat(TTTanTat ttTanTat) async {
    final response = await ttTanTatApiService.postTTTanTat(ttTanTat.toJson());
    return TTTanTat.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<TTTanTat> updateTTTanTat(TTTanTat ttTanTat) async {
    final response = await ttTanTatApiService.putTTTanTat(ttTanTat.toJson());
    return TTTanTat.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteTTTanTat(String id) async {
    await ttTanTatApiService.deleteTTTanTat(id);
  }
}
