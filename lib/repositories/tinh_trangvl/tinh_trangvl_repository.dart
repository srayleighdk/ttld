import 'package:ttld/core/services/tinh_trangvl_api_service.dart';
import 'package:ttld/models/tinh_trangvl_model.dart';

abstract class TinhTrangVLRepository {
  Future<List<TinhTrangViecLam>> getTinhTrangVLs();
  Future<TinhTrangViecLam> addTinhTrangVL(TinhTrangViecLam tinhTrangVL);
  Future<TinhTrangViecLam> updateTinhTrangVL(TinhTrangViecLam tinhTrangVL);
  Future<void> deleteTinhTrangVL(String id);
}

class TinhTrangVLRepositoryImpl implements TinhTrangVLRepository {
  final TinhTrangVLApiService tinhTrangVLApiService;

  TinhTrangVLRepositoryImpl({required this.tinhTrangVLApiService});

  @override
  Future<List<TinhTrangViecLam>> getTinhTrangVLs() async {
    final response = await tinhTrangVLApiService.getTinhTrangVL();
    return (response.data['data'] as List)
        .map((json) => TinhTrangViecLam.fromJson(json))
        .toList();
  }

  @override
  Future<TinhTrangViecLam> addTinhTrangVL(TinhTrangViecLam tinhTrangVL) async {
    final response = await tinhTrangVLApiService.postTinhTrangVL(tinhTrangVL.toJson());
    return TinhTrangViecLam.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<TinhTrangViecLam> updateTinhTrangVL(TinhTrangViecLam tinhTrangVL) async {
    final response = await tinhTrangVLApiService.putTinhTrangVL(tinhTrangVL.toJson());
    return TinhTrangViecLam.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteTinhTrangVL(String id) async {
    await tinhTrangVLApiService.deleteTinhTrangVL(id);
  }
}
