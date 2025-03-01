import 'package:dio/dio.dart';

class HinhThucDaoTaoApiService {
  final Dio _dio;

  HinhThucDaoTaoApiService(this._dio);

  Future<Response> getHinhThucDaoTao() async {
    return await _dio.get('/danhmuc/hinh-thuc/dao-tao');
  }

  Future<Response> postHinhThucDaoTao(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/hinh-thuc/dao-tao', data: data);
  }

  Future<Response> putHinhThucDaoTao(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/hinh-thuc/dao-tao', data: data);
  }

  Future<void> deleteHinhThucDaoTao(String id) async {
    await _dio.delete('/danhmuc/hinh-thuc/dao-tao', queryParameters: {
      'id': id,
    });
  }
}
