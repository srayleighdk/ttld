import 'package:dio/dio.dart';

class HinhThucLamViecApiService {
  final Dio _dio;

  HinhThucLamViecApiService(this._dio);

  Future<Response> getHinhThucLamViec() async {
    return await _dio.get('/bo-sung/hinh-thuc');
  }

  Future<Response> postHinhThucLamViec(Map<String, dynamic> data) async {
    return await _dio.post('/bo-sung/hinh-thuc', data: data);
  }

  Future<Response> putHinhThucLamViec(Map<String, dynamic> data) async {
    return await _dio.put('/bo-sung/hinh-thuc', data: data);
  }

  Future<void> deleteHinhThucLamViec(String id) async {
    await _dio.delete('/bo-sung/hinh-thuc', queryParameters: {
      'id': id,
    });
  }
}
