import 'package:dio/dio.dart';

class TinhTrangVLApiService {
  final Dio _dio;

  TinhTrangVLApiService(this._dio);

  Future<Response> getTinhTrangVL() async {
    return await _dio.get('/danhmuc/tinh-trangvl');
  }

  Future<Response> postTinhTrangVL(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/tinh-trangvl', data: data);
  }

  Future<Response> putTinhTrangVL(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/tinh-trangvl', data: data);
  }

  Future<void> deleteTinhTrangVL(String id) async {
    await _dio.delete('/danhmuc/tinh-trangvl', queryParameters: {
      'id': id,
    });
  }
}
