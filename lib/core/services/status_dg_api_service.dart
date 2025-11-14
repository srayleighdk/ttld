import 'package:dio/dio.dart';
import 'package:ttld/models/status_dg_model.dart';

/// API Service for TblDmStatusDG
/// Endpoint: GET /common/status-dg
class StatusDgApiService {
  final Dio _dio;

  StatusDgApiService(this._dio);

  Future<List<StatusDg>> getStatusDgs() async {
    try {
      final response = await _dio.get('/common/status-dg');
      if (response.statusCode == 200) {
        final dynamic responseData = response.data;
        final List<dynamic> data = responseData is List
            ? responseData
            : (responseData['data'] as List<dynamic>);
        return data.map((json) => StatusDg.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load StatusDg: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching StatusDg: $e');
    }
  }
}
