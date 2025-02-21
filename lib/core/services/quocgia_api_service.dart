import 'package:dio/dio.dart';

class QuocGiaApiService {
  final Dio _dio;

  QuocGiaApiService(this._dio);

  Future<Response> getQuocGia() async {
    return await _dio.get('/danhmuc/quoc-gia');
  }

  Future<Response> postQuocGia(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/quoc-gia', data: data);
  }

  Future<Response> putQuocGia(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/quoc-gia', data: data);
  }

  Future<void> deleteQuocGia(String id) async {
    await _dio.delete('/danhmuc/quoc-gia', queryParameters: {'id': id});
  }
}
