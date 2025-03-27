import 'package:dio/dio.dart';
import 'package:ttld/models/company_model.dart';
import 'package:ttld/models/nhanvien/nhanvien_model.dart';
import 'package:ttld/services/biendong_service.dart';

class BienDongRepository {
  final BienDongService _bienDongService;

  BienDongRepository(this._bienDongService);

  Future<List<NhanVien>> getBienDongList(String? userId) async {
    try {
      final response = await _bienDongService.getBienDongList(userId);
      return (response.data['data'] as List)
          .map((json) => NhanVien.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw Exception('Failed to get bien dong list: ${e.message}');
    }
  }

  Future<List<Company>> getCompanies(
      {int? yearTo, int? status, String? search}) async {
    try {
      final response = await _bienDongService.getBienDong();
      final companies = (response.data['data'] as List)
          .map((json) => Company.fromJson(json))
          .toList();

      // Fetch employees for each company
      for (final company in companies) {
        final nhanVienResponse = await _bienDongService.getBienDongList(company.idDn);
        company.nhanVienList = (nhanVienResponse.data['data'] as List)
            .map((json) => NhanVien.fromJson(json))
            .toList();
      }

      return companies;
    } on DioException catch (e) {
      throw Exception('Failed to get companies: ${e.message}');
    }
  }

  Future<NhanVien> createBienDong(NhanVien bienDong) async {
    try {
      final response = await _bienDongService.createBienDong(bienDong);
      return NhanVien.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to create bien dong: ${e.message}');
    }
  }

  Future<NhanVien> updateBienDong(NhanVien bienDong) async {
    try {
      final response = await _bienDongService.updateBienDong(bienDong);
      return NhanVien.fromJson(response.data);
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
