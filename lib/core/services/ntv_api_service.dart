import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart'; // Import GetIt
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/constants/api_endpoints.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';

final locator = GetIt.instance; // Get the locator instance

class NTVApiService {
  final Dio _dio = locator<ApiClient>().dio; // Use locator to get ApiClient

  Future<List<TblHoSoUngVienModel>> getHoSoUngVienList() async {
    try {
      final response = await _dio.get(ApiEndpoints.hosoUngVien);
      if (response.data == null || response.data['data'] == null) {
        throw Exception('Invalid API response format');
      }
      List<TblHoSoUngVienModel> hoSoUngVienList = (response.data['data'] as List)
          .map((json) => TblHoSoUngVienModel.fromJson(json))
          .toList();
      return hoSoUngVienList;
    } catch (e) {
      throw Exception('Failed to fetch HoSoUngVien list: $e');
    }
  }

  Future<TblHoSoUngVienModel> getHoSoUngVienById(int id) async {
    try {
      final response = await _dio
          .get(ApiEndpoints.hosoUngVienById, queryParameters: {'id': id});
      final TblHoSoUngVienModel hoSoUngVien =
          TblHoSoUngVienModel.fromJson(response.data["data"]);

      return hoSoUngVien;
    } catch (e) {
      print('error: $e');
      throw Exception('Failed to fetch HoSoUngVien by ID: $e');
    }
  }

  Future<TblHoSoUngVienModel> addHoSoUngVien(
      TblHoSoUngVienModel hoSoUngVien) async {
    try {
      final response =
          await _dio.post(ApiEndpoints.hosoUngVien, data: hoSoUngVien.toJson());
      final TblHoSoUngVienModel addedHoSoUngVien =
          TblHoSoUngVienModel.fromJson(response.data);
      return addedHoSoUngVien;
    } catch (e) {
      throw Exception('Failed to add HoSoUngVien: $e');
    }
  }

  Future<Response> updateHoSoUngVien(String id, dynamic formData) async {
    try {
      final response = await _dio.put(ApiEndpoints.hosoUngVien,
          data: formData, queryParameters: {'id': id});
      // final TblHoSoUngVienModel updatedHoSoUngVien =
      //     TblHoSoUngVienModel.fromJson(response.data);
      return response;
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
