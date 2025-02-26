import 'package:dio/dio.dart';

class TTTanTatApiService {
  final Dio _dio;

  TTTanTatApiService(this._dio);

  Future<Response> getTTTanTat() async {
    return await _dio.get('/api/danhmuc/tt-tantat');
  }

  Future<Response> postTTTanTat(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/tt-tantat',  data);
  }

  Future<Response> putTTTanTat(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/tt-tantat',  data);
  }

  Future<void> deleteTTTanTat(String id) async {
    await _dio.delete('/api/danhmuc/tt-tantat', queryParameters: {'id': id});
  }
}
