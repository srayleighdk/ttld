import 'package:dio/dio.dart';

class QuocGiaApiService {
  final Dio _dio;

  QuocGiaApiService(this._dio);

  Future<Response> getQuocGia() async {
    return await _dio.get('/api/danhmuc/quoc-gia');
  }

  Future<Response> postQuocGia(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/quoc-gia',  data);
  }

  Future<Response> putQuocGia(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/quoc-gia',  data);
  }

  Future<void> deleteQuocGia(String id) async {
    await _dio.delete('/api/danhmuc/quoc-gia/$id');
  }
}
