import 'package:dio/dio.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';

class HoSoUngVienApiService {
  final Dio _dio;

  HoSoUngVienApiService(this._dio);

  Future<List<TblHoSoUngVienModel>> getHoSoUngVienList() async {
    // Replace with your actual API endpoint
    const String apiUrl = '/nghiep-vu/hoso-uv';
    final response = await _dio.get(apiUrl);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      final List<dynamic> data = responseData['data'] as List<dynamic>;
      return data.map((json) => TblHoSoUngVienModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load HoSoUngVien: ${response.statusCode}');
    }
  }

  Future<TblHoSoUngVienModel?> getHoSoUngVienByUserId(String userId) async {
    try {
      const String apiUrl = '/nghiep-vu/hoso-uv';
      final response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            response.data as Map<String, dynamic>;
        final List<dynamic> data = responseData['data'] as List<dynamic>;

        // Find the HoSoUngVien that matches the userId
        final hosoList = data.map((json) => TblHoSoUngVienModel.fromJson(json)).toList();

        // Try to find by uvId field (which stores the user ID)
        final hoso = hosoList.firstWhere(
          (item) => item.uvId == userId || item.id == userId,
          orElse: () => hosoList.isNotEmpty ? hosoList.first : throw Exception('No HoSoUngVien found'),
        );

        return hoso;
      } else {
        throw Exception('Failed to load HoSoUngVien: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching HoSoUngVien: $e');
      return null;
    }
  }
}
