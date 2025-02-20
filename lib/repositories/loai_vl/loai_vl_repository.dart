import 'package:ttld/core/services/loai_vl_api_service.dart';
import 'package:ttld/models/loai_vl_model.dart';

abstract class LoaiVLRepository {
  Future<List<LoaiViecLam>> getLoaiVLs();
  Future<LoaiViecLam> addLoaiVL(LoaiViecLam loaiVL);
  Future<LoaiViecLam> updateLoaiVL(LoaiViecLam loaiVL);
  Future<void> deleteLoaiVL(String id);
}

class LoaiVLRepositoryImpl implements LoaiVLRepository {
  final LoaiVLApiService loaiVLApiService;

  LoaiVLRepositoryImpl({required this.loaiVLApiService});

  @override
  Future<List<LoaiViecLam>> getLoaiVLs() async {
    final response = await loaiVLApiService.getLoaiVL();
    return (response.data['data'] as List)
        .map((json) => LoaiViecLam.fromJson(json))
        .toList();
  }

  @override
  Future<LoaiViecLam> addLoaiVL(LoaiViecLam loaiVL) async {
    final response = await loaiVLApiService.postLoaiVL(loaiVL.toJson());
    return LoaiViecLam.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<LoaiViecLam> updateLoaiVL(LoaiViecLam loaiVL) async {
    final response = await loaiVLApiService.putLoaiVL(loaiVL.toJson());
    return LoaiViecLam.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteLoaiVL(String id) async {
    await loaiVLApiService.deleteLoaiVL(id);
  }
}
