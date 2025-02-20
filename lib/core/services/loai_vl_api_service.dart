import 'package:dio/dio.dart';

class LoaiVLApiService {
  final Dio _dio;

  LoaiVLApiService(this._dio);

  Future<Response> getLoaiVL() async {
    return await _dio.get('/api/danhmuc/loai-vl');
  }

  Future<Response> postLoaiVL(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/loai-vl', data);
  }

  Future<Response> putLoaiVL(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/loai-vl', data);
  }

  Future<void> deleteLoaiVL(String id) async {
    await _dio.delete('/api/danhmuc/loai-vl/$id');
  }
}
