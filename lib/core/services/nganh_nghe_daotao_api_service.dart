import 'package:dio/dio.dart';

class NganhNgheDaoTaoApiService {
  final Dio _dio;

  NganhNgheDaoTaoApiService(this._dio);

  Future<Response> getNganhNgheDaoTao() async {
    return await _dio.get('/api/danhmuc/nganh-nghe/dao-tao');
  }

  Future<Response> postNganhNgheDaoTao(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/nganh-nghe/dao-tao', data);
  }

  Future<Response> putNganhNgheDaoTao(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/nganh-nghe/dao-tao', data);
  }

  Future<void> deleteNganhNgheDaoTao(String id) async {
    await _dio.delete('/api/danhmuc/nganh-nghe/dao-tao/$id');
  }
}
