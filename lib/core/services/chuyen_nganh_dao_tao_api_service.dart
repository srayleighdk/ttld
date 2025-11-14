import 'package:dio/dio.dart';
import 'package:ttld/models/chuyen_nganh_dao_tao_model.dart';

/// API Service for TblDmBacDaoTaoC3 (Chuyên ngành đào tạo)
/// Endpoint: GET /common/chuyen-nganh
class ChuyenNganhDaoTaoApiService {
  final Dio _dio;

  ChuyenNganhDaoTaoApiService(this._dio);

  /// Get all chuyen nganh dao tao records from /common/chuyen-nganh
  Future<List<ChuyenNganhDaoTao>> getChuyenNganhDaoTaos() async {
    try {
      final response = await _dio.get('/common/chuyen-nganh');
      if (response.statusCode == 200) {
        // Handle both array response and {data: [...]} response
        final dynamic responseData = response.data;
        final List<dynamic> data = responseData is List
            ? responseData
            : (responseData['data'] as List<dynamic>);
        return data.map((json) => ChuyenNganhDaoTao.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load ChuyenNganhDaoTao: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching ChuyenNganhDaoTao: $e');
    }
  }
}
