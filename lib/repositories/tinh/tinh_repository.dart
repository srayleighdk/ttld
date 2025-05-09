import 'package:ttld/core/services/tinh_api_service.dart';
import 'package:ttld/models/tinh/tinh.dart';

abstract class TinhRepository {
  Future<List<Tinh>> getTinhs();
  Future<Tinh> addTinh(Tinh tinh);
  Future<Tinh> updateTinh(Tinh tinh);
  Future<void> deleteTinh(String id);
}

class TinhRepositoryImpl implements TinhRepository {
  final TinhApiService tinhApiService;

  TinhRepositoryImpl({required this.tinhApiService});

  @override
  Future<List<Tinh>> getTinhs() async {
    final response = await tinhApiService.getTinh();
    return (response['data'] as List)
        .map((json) => Tinh.fromJson(json))
        .toList();
  }

  @override
  Future<Tinh> addTinh(Tinh tinh) async {
    final response = await tinhApiService.postTinh(tinh.toJson());
    return Tinh.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<Tinh> updateTinh(Tinh tinh) async {
    final response = await tinhApiService.putTinh(tinh.toJson());
    return Tinh.fromJson(response['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteTinh(String id) async {
    await tinhApiService.deleteTinh(id);
  }
}
