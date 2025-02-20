import 'package:dio/dio.dart';

class HinhThucDaoTaoApiService {
  final Dio _dio;

  HinhThucDaoTaoApiService(this._dio);

  Future<Response> getHinhThucDaoTao() async {
    return await _dio.get('/api/danhmuc/hinh-thuc/dao-tao');
  }

  Future<Response> postHinhThucDaoTao(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/hinh-thuc/dao-tao', data);
  }

  Future<Response> putHinhThucDaoTao(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/hinh-thuc/dao-tao', data);
  }

  Future<void> deleteHinhThucDaoTao(String id) async {
    await _dio.delete('/api/danhmuc/hinh-thuc/dao-tao/$id');
  }
}
