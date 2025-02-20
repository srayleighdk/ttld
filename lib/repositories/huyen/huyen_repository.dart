import 'package:ttld/core/api_client.dart';
import 'package:ttld/models/huyen/huyen.dart';

abstract class HuyenRepository {
  Future<List<Huyen>> getHuyens();
  Future<Huyen> addHuyen(Huyen huyen);
  Future<Huyen> updateHuyen(Huyen huyen);
  Future<void> deleteHuyen(String id);
}

class HuyenRepositoryImpl implements HuyenRepository {
  final ApiClient apiClient;

  HuyenRepositoryImpl({required this.apiClient});

  @override
  Future<List<Huyen>> getHuyens() async {
    final response = await apiClient.getHuyen();
    return (response as List).map((json) => Huyen.fromJson(json)).toList();
  }

  @override
  Future<Huyen> addHuyen(Huyen huyen) async {
    final response = await apiClient.postHuyen(huyen.toJson());
    return Huyen.fromJson(response);
  }

  @override
  Future<Huyen> updateHuyen(Huyen huyen) async {
    final response = await apiClient.putHuyen(huyen.toJson());
    return Huyen.fromJson(response);
  }

  @override
  Future<void> deleteHuyen(String id) async {
    await apiClient.deleteHuyen(id);
  }
}
