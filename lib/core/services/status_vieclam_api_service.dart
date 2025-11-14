import 'package:dio/dio.dart';
import 'package:ttld/models/status_vieclam_model.dart';

/// API Service for TblDmStatusViecLam
/// Endpoint: GET /common/status-vl
class StatusViecLamApiService {
  final Dio _dio;

  StatusViecLamApiService(this._dio);

  /// Get all employment status records from /common/status-vl
  Future<List<StatusViecLam>> getStatusViecLams() async {
    try {
      final response = await _dio.get('/common/status-vl');
      if (response.statusCode == 200) {
        // Handle both array response and {data: [...]} response
        final dynamic responseData = response.data;
        final List<dynamic> data = responseData is List
            ? responseData
            : (responseData['data'] as List<dynamic>);
        return data.map((json) => StatusViecLam.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load StatusViecLam: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching StatusViecLam: $e');
    }
  }
}
