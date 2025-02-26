import 'package:dio/dio.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/constants/api_endpoints.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';

class NTVApiService {
  final Dio _dio = ApiClient().dio;

  Future<List<TblHoSoUngVienModel>> getHoSoUngVienList() async {
    try {
      final response = await _dio.get(ApiEndpoints.hosoUngVien);
      List<TblHoSoUngVienModel> hoSoUngVienList = (response.data as List)
          .map((json) => TblHoSoUngVienModel.fromJson(json))
          .toList();
      return hoSoUngVienList;
    } catch (e) {
      throw Exception('Failed to fetch HoSoUngVien list: $e');
    }
  }

  Future<TblHoSoUngVienModel> getHoSoUngVienById(String id) async {
    try {
      final response = await _dio.get(ApiEndpoints.hosoUngVienById,
          queryParameters: {'id': id});
      final TblHoSoUngVienModel hoSoUngVien =
          TblHoSoUngVienModel.fromJson(response.data["data"]);
      return hoSoUngVien;
    } catch (e) {
      throw Exception('Failed to fetch HoSoUngVien by ID: $e');
    }
  }

  Future<TblHoSoUngVienModel> addHoSoUngVien(
      TblHoSoUngVienModel hoSoUngVien) async {
    try {
      final response =
          await _dio.post(ApiEndpoints.hosoUngVien,  hoSoUngVien.toJson());
      final TblHoSoUngVienModel addedHoSoUngVien =
          TblHoSoUngVienModel.fromJson(response.data);
      return addedHoSoUngVien;
    } catch (e) {
      throw Exception('Failed to add HoSoUngVien: $e');
    }
  }

  Future<TblHoSoUngVienModel> updateHoSoUngVien(
      TblHoSoUngVienModel hoSoUngVien) async {
    try {
      final response = await _dio.put(ApiEndpoints.hosoUngVien,
           hoSoUngVien.toJson(),
          queryParameters: {'id': hoSoUngVien.idHoSo});
      final TblHoSoUngVienModel updatedHoSoUngVien =
          TblHoSoUngVienModel.fromJson(response.data);
      return updatedHoSoUngVien;
    } catch (e) {
      throw Exception('Failed to update HoSoUngVien: $e');
    }
  }

  Future<void> deleteHoSoUngVien(int id) async {
    try {
      await _dio.delete('${ApiEndpoints.hosoUngVien}/$id');
    } catch (e) {
      throw Exception('Failed to delete HoSoUngVien: $e');
    }
  }
}
