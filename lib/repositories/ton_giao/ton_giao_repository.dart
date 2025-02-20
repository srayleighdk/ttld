import 'package:ttld/core/services/ton_giao_api_service.dart';
import 'package:ttld/models/ton_giao_model.dart';

abstract class TonGiaoRepository {
  Future<List<TonGiao>> getTonGiaos();
  Future<TonGiao> addTonGiao(TonGiao tonGiao);
  Future<TonGiao> updateTonGiao(TonGiao tonGiao);
  Future<void> deleteTonGiao(String id);
}

class TonGiaoRepositoryImpl implements TonGiaoRepository {
  final TonGiaoApiService tonGiaoApiService;

  TonGiaoRepositoryImpl({required this.tonGiaoApiService});

  @override
  Future<List<TonGiao>> getTonGiaos() async {
    final response = await tonGiaoApiService.getTonGiao();
    return (response.data['data'] as List)
        .map((json) => TonGiao.fromJson(json))
        .toList();
  }

  @override
  Future<TonGiao> addTonGiao(TonGiao tonGiao) async {
    final response = await tonGiaoApiService.postTonGiao(tonGiao.toJson());
    return TonGiao.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<TonGiao> updateTonGiao(TonGiao tonGiao) async {
    final response = await tonGiaoApiService.putTonGiao(tonGiao.toJson());
    return TonGiao.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteTonGiao(String id) async {
    await tonGiaoApiService.deleteTonGiao(id);
  }
}
