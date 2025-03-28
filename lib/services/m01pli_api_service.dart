import 'package:dio/dio.dart';
import '../models/m01pli/m01pli_model.dart';

class M01PliApiService {
  final Dio _dio;

  M01PliApiService(this._dio);

  Future<Map<String, dynamic>> getM01Plis({int page = 1, int limit = 10}) async {
    try {
      final response = await _dio.get('/tttt/m01-pli', queryParameters: {
        'page': page,
        'limit': limit,
      });
      return {
        'data': (response.data['data'] as List)
            .map((e) => M01Pli.fromJson(e))
            .toList(),
        'total': response.data['total'],
      };
    } on DioException catch (e) {
      throw Exception('Failed to load M01Pli: ${e.message}');
    }
  }

  Future<M01Pli> createM01Pli(M01Pli pli) async {
    try {
      final response = await _dio.post(
        '/tttt/m01-pli',
        data: pli.toJson(),
      );
      return M01Pli.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to create M01Pli: ${e.message}');
    }
  }

  Future<M01Pli> updateM01Pli(M01Pli pli) async {
    try {
      final response = await _dio.put(
        '/tttt/m01-pli',
        data: pli.toJson(),
      );
      return M01Pli.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to update M01Pli: ${e.message}');
    }
  }

  Future<void> deleteM01Pli(String idphieu) async {
    try {
      await _dio.delete(
        '/tttt/m01-pli',
        data: {'idphieu': idphieu},
      );
    } on DioException catch (e) {
      throw Exception('Failed to delete M01Pli: ${e.message}');
    }
  }
}
