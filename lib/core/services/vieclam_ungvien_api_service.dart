import 'package:dio/dio.dart';
import 'package:ttld/models/tblViecLamUngVien/vieclam_ungvien_model.dart';

class ViecLamUngVienApiService {
  final Dio _dio;

  ViecLamUngVienApiService(this._dio);

  Future<List<TblViecLamUngVienModel>> getViecLamUngVienList() async {
    try {
      const String apiUrl = '/tblVieclamUngVien';
      final response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((json) => TblViecLamUngVienModel.fromJson(json))
            .toList();
      } else {
        throw Exception(
            'Failed to load ViecLamUngVien: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching ViecLamUngVien: $e');
    }
  }
}
