import 'package:ttld/core/services/hinh_thuc_loai_hinh_api_service.dart';
import 'package:ttld/models/hinh_thuc_loai_hinh_model.dart';

abstract class HinhThucLoaiHinhRepository {
  Future<List<HinhThucLoaiHinh>> getHinhThucLoaiHinhs();
  Future<HinhThucLoaiHinh> addHinhThucLoaiHinh(HinhThucLoaiHinh hinhThucLoaiHinh);
  Future<HinhThucLoaiHinh> updateHinhThucLoaiHinh(HinhThucLoaiHinh hinhThucLoaiHinh);
  Future<void> deleteHinhThucLoaiHinh(String id);
}

class HinhThucLoaiHinhRepositoryImpl implements HinhThucLoaiHinhRepository {
  final HinhThucLoaiHinhApiService hinhThucLoaiHinhApiService;

  HinhThucLoaiHinhRepositoryImpl({required this.hinhThucLoaiHinhApiService});

  @override
  Future<List<HinhThucLoaiHinh>> getHinhThucLoaiHinhs() async {
    final response = await hinhThucLoaiHinhApiService.getHinhThucLoaiHinh();
    return (response.data['data'] as List)
        .map((json) => HinhThucLoaiHinh.fromJson(json))
        .toList();
  }

  @override
  Future<HinhThucLoaiHinh> addHinhThucLoaiHinh(HinhThucLoaiHinh hinhThucLoaiHinh) async {
    final response = await hinhThucLoaiHinhApiService.postHinhThucLoaiHinh(hinhThucLoaiHinh.toJson());
    return HinhThucLoaiHinh.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<HinhThucLoaiHinh> updateHinhThucLoaiHinh(HinhThucLoaiHinh hinhThucLoaiHinh) async {
    final response = await hinhThucLoaiHinhApiService.putHinhThucLoaiHinh(hinhThucLoaiHinh.toJson());
    return HinhThucLoaiHinh.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteHinhThucLoaiHinh(String id) async {
    await hinhThucLoaiHinhApiService.deleteHinhThucLoaiHinh(id);
  }
}
