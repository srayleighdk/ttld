import 'package:dio/dio.dart';
import '../models/m01apli/m01apli_model.dart';

class M01APliApiService {
  final Dio _dio;

  M01APliApiService(this._dio);

  Future<List<M01APli>> getM01APlis() async {
    try {
      final response = await _dio.get('/api/tttt/m01a-pli');
      return (response.data as List).map((e) => M01APli.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load M01APli: ${e.message}');
    }
  }

  Future<M01APli> createM01APli(M01APli pli) async {
    try {
      final response = await _dio.post(
        '/api/tttt/m01a-pli',
        data: pli.toJson(),
      );
      return M01APli.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to create M01APli: ${e.message}');
    }
  }

  Future<M01APli> updateM01APli(M01APli pli) async {
    try {
      final response = await _dio.put(
        '/api/tttt/m01a-pli',
        data: pli.toJson(),
      );
      return M01APli.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to update M01APli: ${e.message}');
    }
  }

  Future<void> deleteM01APli(String idphieu) async {
    try {
      await _dio.delete(
        '/api/tttt/m01a-pli',
        data: {'idphieu': idphieu},
      );
    } on DioException catch (e) {
      throw Exception('Failed to delete M01APli: ${e.message}');
    }
  }
}
