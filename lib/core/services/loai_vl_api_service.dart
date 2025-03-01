import 'package:dio/dio.dart';

class LoaiVLApiService {
  final Dio _dio;

  LoaiVLApiService(this._dio);

  Future<Response> getLoaiVL() async {
    return await _dio.get('/danhmuc/loai-vl');
  }

  Future<Response> postLoaiVL(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/loai-vl', data: data);
  }

  Future<Response> putLoaiVL(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/loai-vl', data: data);
  }

  Future<void> deleteLoaiVL(String id) async {
    await _dio.delete('/danhmuc/loai-vl', queryParameters: {
      'id': id,
    });
  }
}
