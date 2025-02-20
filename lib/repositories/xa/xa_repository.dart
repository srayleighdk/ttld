import 'package:ttld/core/services/xa_api_service.dart';
import 'package:ttld/models/xa/xa.dart';

abstract class XaRepository {
  Future<List<Xa>> getXas();
  Future<Xa> addXa(Xa xa);
  Future<Xa> updateXa(Xa xa);
  Future<void> deleteXa(String id);
  Future<List<Xa>> getXasByHuyen(String mahuyen);
}

class XaRepositoryImpl implements XaRepository {
  final XaApiService xaApiService;

  XaRepositoryImpl({required this.xaApiService});

  @override
  Future<List<Xa>> getXas() async {
    final response = await xaApiService.getXa();
    return (response['data'] as List)
        .map((json) => Xa.fromJson(json))
        .toList();
  }

  @override
  Future<Xa> addXa(Xa xa) async {
    final response = await xaApiService.postXa(xa.toJson());
    return Xa.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<Xa> updateXa(Xa xa) async {
    final response = await xaApiService.putXa(xa.toJson());
    return Xa.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteXa(String id) async {
    await xaApiService.deleteXa(id);
  }

  @override
  Future<List<Xa>> getXasByHuyen(String mahuyen) async {
    final response = await xaApiService.getXaByHuyen(mahuyen);
    return (response['data'] as List)
        .map((json) => Xa.fromJson(json))
        .toList();
  }
}
