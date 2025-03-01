import 'package:dio/dio.dart';

class TTTanTatApiService {
  final Dio _dio;

  TTTanTatApiService(this._dio);

  Future<Response> getTTTanTat() async {
    return await _dio.get('/danhmuc/tt-tantat');
  }

  Future<Response> postTTTanTat(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/tt-tantat', data: data);
  }

  Future<Response> putTTTanTat(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/tt-tantat', data: data);
  }

  Future<void> deleteTTTanTat(String id) async {
    await _dio.delete('/danhmuc/tt-tantat', queryParameters: {'id': id});
  }
}
