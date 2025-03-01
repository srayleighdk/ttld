import 'package:ttld/core/services/tt_tantat_api_service.dart';
import 'package:ttld/models/tttantat/tttantat.dart';

abstract class TTTanTatRepository {
  Future<List<TtTantat>> getTTTanTats();
  Future<TtTantat> addTTTanTat(TtTantat ttTanTat);
  Future<TtTantat> updateTTTanTat(TtTantat ttTanTat);
  Future<void> deleteTTTanTat(String id);
}

class TTTanTatRepositoryImpl implements TTTanTatRepository {
  final TTTanTatApiService ttTanTatApiService;

  TTTanTatRepositoryImpl({required this.ttTanTatApiService});

  @override
  Future<List<TtTantat>> getTTTanTats() async {
    final response = await ttTanTatApiService.getTTTanTat();
    return (response.data['data'] as List)
        .map((json) => TtTantat.fromJson(json))
        .toList();
  }

  @override
  Future<TtTantat> addTTTanTat(TtTantat ttTanTat) async {
    final response = await ttTanTatApiService.postTTTanTat(ttTanTat.toJson());
    return TtTantat.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<TtTantat> updateTTTanTat(TtTantat ttTanTat) async {
    final response = await ttTanTatApiService.putTTTanTat(ttTanTat.toJson());
    return TtTantat.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteTTTanTat(String id) async {
    await ttTanTatApiService.deleteTTTanTat(id);
  }
}
