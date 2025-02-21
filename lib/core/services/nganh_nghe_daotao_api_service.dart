import 'package:dio/dio.dart';

class NganhNgheDaoTaoApiService {
  final Dio _dio;

  NganhNgheDaoTaoApiService(this._dio);

  Future<Response> getNganhNgheDaoTao() async {
    return await _dio.get('/danhmuc/nganh-nghe/dao-tao');
  }

  Future<Response> postNganhNgheDaoTao(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/nganh-nghe/dao-tao', data: data);
  }

  Future<Response> putNganhNgheDaoTao(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/nganh-nghe/dao-tao', data: data);
  }

  Future<void> deleteNganhNgheDaoTao(String id) async {
    await _dio
        .delete('/danhmuc/nganh-nghe/dao-tao', queryParameters: {'id': id});
  }
}
