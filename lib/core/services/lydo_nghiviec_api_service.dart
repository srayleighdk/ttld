import 'package:dio/dio.dart';
import 'package:ttld/models/lydo_nghiviec/lydo_nghiviec_model.dart';

class LydoNghiviecApiService {
  final Dio _dio;

  LydoNghiviecApiService(this._dio);

  Future<List<LydoNghiviec>> getLydoNghiviecs() async {
    try {
      final response = await _dio.get('/common/lydo-bd');
      if (response.statusCode == 200) {
        // Handle both array response and {data: [...]} response
        final dynamic responseData = response.data;
        final List<dynamic> data = responseData is List
            ? responseData
            : (responseData['data'] as List<dynamic>);
        return data.map((json) => LydoNghiviec.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load LydoNghiviecs: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching LydoNghiviecs: $e');
    }
  }
}
