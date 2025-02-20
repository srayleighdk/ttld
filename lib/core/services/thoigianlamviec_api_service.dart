import 'package:dio/dio.dart';

class ThoiGianLamViecApiService {
  final Dio _dio;

  ThoiGianLamViecApiService(this._dio);

  Future<Response> getThoiGianLamViec() async {
    return await _dio.get('/api/danhmuc/tg-lamviec');
  }

  Future<Response> postThoiGianLamViec(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/tg-lamviec', data);
  }

  Future<Response> putThoiGianLamViec(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/tg-lamviec', data);
  }

  Future<void> deleteThoiGianLamViec(String id) async {
    await _dio.delete('/api/danhmuc/tg-lamviec/$id');
  }
}
