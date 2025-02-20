import 'package:dio/dio.dart';

class NguonViecLamApiService {
  final Dio _dio;

  NguonViecLamApiService(this._dio);

  Future<Response> getNguonViecLam() async {
    return await _dio.get('/api/danhmuc/nguon-vieclam');
  }

  Future<Response> postNguonViecLam(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/nguon-vieclam', data);
  }

  Future<Response> putNguonViecLam(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/nguon-vieclam', data);
  }

  Future<void> deleteNguonViecLam(String id) async {
    await _dio.delete('/api/danhmuc/nguon-vieclam/$id');
  }
}
