import 'package:dio/dio.dart';

class NguonThuThapApiService {
  final Dio _dio;

  NguonThuThapApiService(this._dio);

  Future<Response> getNguonThuThap() async {
    return await _dio.get('/api/danhmuc/nguon-thuthap');
  }

  Future<Response> postNguonThuThap(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/nguon-thuthap', data);
  }

  Future<Response> putNguonThuThap(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/nguon-thuthap', data);
  }

  Future<void> deleteNguonThuThap(String id) async {
    await _dio.delete('/api/danhmuc/nguon-thuthap/$id');
  }
}
