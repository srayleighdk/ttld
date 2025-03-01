import 'package:dio/dio.dart';

class DoiTuongApiService {
  final Dio _dio;

  DoiTuongApiService(this._dio);

  Future<Response> getDoiTuongs() async {
    return await _dio.get('/danhmuc/doi-tuong');
  }

  Future<Response> postDoiTuong(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/doi-tuong', data: data);
  }

  Future<Response> putDoiTuong(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/doi-tuong', data: data);
  }

  Future<void> deleteDoiTuong(String id) async {
    await _dio.delete('/danhmuc/doi-tuong', queryParameters: {'id': id});
  }
}
