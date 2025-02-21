import 'package:dio/dio.dart';

class ThoiGianLamViecApiService {
  final Dio _dio;

  ThoiGianLamViecApiService(this._dio);

  Future<Response> getThoiGianLamViec() async {
    return await _dio.get('/danhmuc/tg-lamviec');
  }

  Future<Response> postThoiGianLamViec(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/tg-lamviec', data: data);
  }

  Future<Response> putThoiGianLamViec(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/tg-lamviec', data: data);
  }

  Future<void> deleteThoiGianLamViec(String id) async {
    await _dio.delete('/danhmuc/tg-lamviec', queryParameters: {'id': id});
  }
}
