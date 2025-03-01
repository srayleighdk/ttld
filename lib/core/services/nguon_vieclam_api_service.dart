import 'package:dio/dio.dart';

class NguonViecLamApiService {
  final Dio _dio;

  NguonViecLamApiService(this._dio);

  Future<Response> getNguonViecLam() async {
    return await _dio.get('/danhmuc/nguon-vieclam');
  }

  Future<Response> postNguonViecLam(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/nguon-vieclam', data: data);
  }

  Future<Response> putNguonViecLam(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/nguon-vieclam', data: data);
  }

  Future<void> deleteNguonViecLam(String id) async {
    await _dio.delete('/danhmuc/nguon-vieclam', queryParameters: {
      'id': id,
    });
  }
}
