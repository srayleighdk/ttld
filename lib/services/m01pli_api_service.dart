import 'package:dio/dio.dart';
import '../models/m01pli/m01pli_model.dart';

class M01PliApiService {
  final Dio _dio;

  M01PliApiService(this._dio);

  Future<List<M01Pli>> getM01Plis() async {
    try {
      final response = await _dio.get('/api/tttt/m01-pli');
      return (response.data as List).map((e) => M01Pli.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load M01Pli: ${e.message}');
    }
  }

  Future<M01Pli> createM01Pli(M01Pli pli) async {
    try {
      final response = await _dio.post(
        '/api/tttt/m01-pli',
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
        '/api/tttt/m01-pli',
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
        '/api/tttt/m01-pli',
        data: {'idphieu': idphieu},
      );
    } on DioException catch (e) {
      throw Exception('Failed to delete M01Pli: ${e.message}');
    }
  }
}
