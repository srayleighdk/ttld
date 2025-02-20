import 'package:ttld/core/services/huyen_api_service.dart';
import 'package:ttld/models/huyen/huyen.dart';

abstract class HuyenRepository {
  Future<List<Huyen>> getHuyens();
  Future<Huyen> addHuyen(Huyen huyen);
  Future<Huyen> updateHuyen(Huyen huyen);
  Future<void> deleteHuyen(String id);
  Future<List<Huyen>> getHuyensByTinh(String matinh);
}

class HuyenRepositoryImpl implements HuyenRepository {
  final HuyenApiService huyenApiService;

  HuyenRepositoryImpl({required this.huyenApiService});

  @override
  Future<List<Huyen>> getHuyens() async {
    final response = await huyenApiService.getHuyen();
    return (response['data'] as List).map((json) => Huyen.fromJson(json)).toList();
  }

  @override
  Future<Huyen> addHuyen(Huyen huyen) async {
    final response = await huyenApiService.postHuyen(huyen.toJson());
    return Huyen.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<Huyen> updateHuyen(Huyen huyen) async {
    final response = await huyenApiService.putHuyen(huyen.toJson());
    return Huyen.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteHuyen(String id) async {
    await huyenApiService.deleteHuyen(id);
  }

  @override
  Future<List<Huyen>> getHuyensByTinh(String matinh) async {
    final response = await huyenApiService.getHuyenByTinh(matinh);
    return (response['data'] as List).map((json) => Huyen.fromJson(json)).toList();
  }
}
