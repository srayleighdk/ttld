import 'package:dio/dio.dart';
import '../models/m02pli/m02pli_model.dart';

class M02PliApiService {
  final Dio _dio;

  M02PliApiService(this._dio);

  Future<List<M02Pli>> getM02Plis() async {
    try {
      final response = await _dio.get('/api/tttt/m02-pli');
      return (response.data as List).map((e) => M02Pli.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load M02Pli: ${e.message}');
    }
  }

  Future<M02Pli> createM02Pli(M02Pli pli) async {
    try {
      final response = await _dio.post(
        '/api/tttt/m02-pli',
        data: pli.toJson(),
      );
      return M02Pli.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to create M02Pli: ${e.message}');
    }
  }

  Future<M02Pli> updateM02Pli(M02Pli pli) async {
    try {
      final response = await _dio.put(
        '/api/tttt/m02-pli',
        data: pli.toJson(),
      );
      return M02Pli.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to update M02Pli: ${e.message}');
    }
  }

  Future<void> deleteM02Pli(String idphieu) async {
    try {
      await _dio.delete(
        '/api/tttt/m02-pli',
        data: {'idphieu': idphieu},
      );
    } on DioException catch (e) {
      throw Exception('Failed to delete M02Pli: ${e.message}');
    }
  }
}
