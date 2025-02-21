import 'package:dio/dio.dart';
import 'package:ttld/core/constants/api_endpoints.dart';
import 'package:ttld/models/chuc_danh_model.dart';

class ChucDanhApiService {
  final Dio _dio = Dio();

  Future<List<ChucDanhModel>> getChucDanhs() async {
    try {
      final response = await _dio.get(ApiEndpoints.chucDanh);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ChucDanhModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load chuc danh: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load chuc danh: $e');
    }
  }
}
