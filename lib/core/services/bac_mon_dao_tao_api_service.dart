import 'package:dio/dio.dart';
import 'package:ttld/models/bac_mon_dao_tao_model.dart';

/// API Service for TblDmBacMonDaoTao
/// Endpoint: GET /common/bac-hoc
class BacMonDaoTaoApiService {
  final Dio _dio;

  BacMonDaoTaoApiService(this._dio);

  /// Get all bac mon dao tao records from /common/bac-hoc
  Future<List<BacMonDaoTao>> getBacMonDaoTaos() async {
    try {
      final response = await _dio.get('/common/bac-hoc');
      if (response.statusCode == 200) {
        // Handle both array response and {data: [...]} response
        final dynamic responseData = response.data;
        final List<dynamic> data = responseData is List
            ? responseData
            : (responseData['data'] as List<dynamic>);
        return data.map((json) => BacMonDaoTao.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load BacMonDaoTao: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching BacMonDaoTao: $e');
    }
  }
}
