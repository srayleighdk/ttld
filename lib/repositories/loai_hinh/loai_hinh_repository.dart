import 'package:ttld/core/services/loai_hinh_api_service.dart';
import 'package:ttld/models/loai_hinh_model.dart';

abstract class LoaiHinhRepository {
  Future<List<LoaiHinh>> getLoaiHinhs();
  Future<LoaiHinh> addLoaiHinh(LoaiHinh loaiHinh);
  Future<LoaiHinh> updateLoaiHinh(LoaiHinh loaiHinh);
  Future<void> deleteLoaiHinh(String id);
}

class LoaiHinhRepositoryImpl implements LoaiHinhRepository {
  final LoaiHinhApiService loaiHinhApiService;

  LoaiHinhRepositoryImpl({required this.loaiHinhApiService});

  @override
  Future<List<LoaiHinh>> getLoaiHinhs() async {
    final response = await loaiHinhApiService.getLoaiHinh();
    return (response.data['data'] as List)
        .map((json) => LoaiHinh.fromJson(json))
        .toList();
  }

  @override
  Future<LoaiHinh> addLoaiHinh(LoaiHinh loaiHinh) async {
    final response = await loaiHinhApiService.postLoaiHinh(loaiHinh.toJson());
    return LoaiHinh.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<LoaiHinh> updateLoaiHinh(LoaiHinh loaiHinh) async {
    final response = await loaiHinhApiService.putLoaiHinh(loaiHinh.toJson());
    return LoaiHinh.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteLoaiHinh(String id) async {
    await loaiHinhApiService.deleteLoaiHinh(id);
  }
}
