import 'package:dio/dio.dart';

class TinhTrangVLApiService {
  final Dio _dio;

  TinhTrangVLApiService(this._dio);

  Future<Response> getTinhTrangVL() async {
    return await _dio.get('/api/danhmuc/tinh-trangvl');
  }

  Future<Response> postTinhTrangVL(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/tinh-trangvl', data);
  }

  Future<Response> putTinhTrangVL(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/tinh-trangvl', data);
  }

  Future<void> deleteTinhTrangVL(String id) async {
    await _dio.delete('/api/danhmuc/tinh-trangvl/$id');
  }
}
