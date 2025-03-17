import 'package:dio/dio.dart';
import 'package:ttld/models/biendong_model.dart';
import 'package:ttld/services/biendong_service.dart';

class BienDongRepository {
  final BienDongService _bienDongService;

  BienDongRepository(this._bienDongService);

  Future<List<BienDong>> getBienDongList(String? userId) async {
    try {
      final response = await _bienDongService.getBienDongList(userId);
      return (response.data as List)
          .map((json) => BienDong.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception('Failed to get bien dong list: ${e.message}');
    }
  }

  Future<BienDong> createBienDong(BienDong bienDong) async {
    try {
      final response = await _bienDongService.createBienDong(bienDong);
      return BienDong.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to create bien dong: ${e.message}');
    }
  }

  Future<BienDong> updateBienDong(BienDong bienDong) async {
    try {
      final response = await _bienDongService.updateBienDong(bienDong);
      return BienDong.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to update bien dong: ${e.message}');
    }
  }

  Future<void> deleteBienDong(String id) async {
    try {
      await _bienDongService.deleteBienDong(id);
    } on DioException catch (e) {
      throw Exception('Failed to delete bien dong: ${e.message}');
    }
  }
}
