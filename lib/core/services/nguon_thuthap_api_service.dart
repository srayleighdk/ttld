import 'package:dio/dio.dart';

class NguonThuThapApiService {
  final Dio _dio;

  NguonThuThapApiService(this._dio);

  Future<Response> getNguonThuThap() async {
    return await _dio.get('/danhmuc/nguon-thuthap');
  }

  Future<Response> postNguonThuThap(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/nguon-thuthap', data: data);
  }

  Future<Response> putNguonThuThap(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/nguon-thuthap', data: data);
  }

  Future<void> deleteNguonThuThap(String id) async {
    await _dio.delete('/danhmuc/nguon-thuthap', queryParameters: {
      'id': id,
    });
  }
}
