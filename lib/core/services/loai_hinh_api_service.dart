import 'package:dio/dio.dart';

class LoaiHinhApiService {
  final Dio _dio;

  LoaiHinhApiService(this._dio);

  Future<Response> getLoaiHinh() async {
    return await _dio.get('/api/danhmuc/hinh-thuc/loai-hinh');
  }

  Future<Response> postLoaiHinh(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/hinh-thuc/loai-hinh', data);
  }

  Future<Response> putLoaiHinh(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/hinh-thuc/loai-hinh', data);
  }

  Future<void> deleteLoaiHinh(String id) async {
    await _dio.delete('/api/danhmuc/hinh-thuc/loai-hinh/$id');
  }
}
