import 'package:ttld/core/services/hinhthuc_doanhnghiep_api_service.dart';
import 'package:ttld/models/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_model.dart';

abstract class HinhThucDoanhNghiepRepository {
  Future<List<HinhThucDoanhNghiep>> getHinhThucDoanhNghieps();
  Future<HinhThucDoanhNghiep> addHinhThucDoanhNghiep(HinhThucDoanhNghiep hinhThucDoanhNghiep);
  Future<HinhThucDoanhNghiep> updateHinhThucDoanhNghiep(HinhThucDoanhNghiep hinhThucDoanhNghiep);
  Future<void> deleteHinhThucDoanhNghiep(String id);
}

class HinhThucDoanhNghiepRepositoryImpl implements HinhThucDoanhNghiepRepository {
  final HinhThucDoanhNghiepApiService hinhThucDoanhNghiepApiService;

  HinhThucDoanhNghiepRepositoryImpl({required this.hinhThucDoanhNghiepApiService});

  @override
  Future<List<HinhThucDoanhNghiep>> getHinhThucDoanhNghieps() async {
    final response = await hinhThucDoanhNghiepApiService.getHinhThucDoanhNghiep();
    return (response.data['data'] as List)
        .map((json) => HinhThucDoanhNghiep.fromJson(json))
        .toList();
  }

  @override
  Future<HinhThucDoanhNghiep> addHinhThucDoanhNghiep(HinhThucDoanhNghiep hinhThucDoanhNghiep) async {
    final response = await hinhThucDoanhNghiepApiService.postHinhThucDoanhNghiep(hinhThucDoanhNghiep.toJson());
    return HinhThucDoanhNghiep.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<HinhThucDoanhNghiep> updateHinhThucDoanhNghiep(HinhThucDoanhNghiep hinhThucDoanhNghiep) async {
    final response = await hinhThucDoanhNghiepApiService.putHinhThucDoanhNghiep(hinhThucDoanhNghiep.toJson());
    return HinhThucDoanhNghiep.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteHinhThucDoanhNghiep(String id) async {
    await hinhThucDoanhNghiepApiService.deleteHinhThucDoanhNghiep(id);
  }
}
