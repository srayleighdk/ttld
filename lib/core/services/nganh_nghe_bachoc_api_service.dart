import 'package:dio/dio.dart';

class NganhNgheBacHocApiService {
  final Dio _dio;

  NganhNgheBacHocApiService(this._dio);

  Future<Response> getNganhNgheBacHoc() async {
    return await _dio.get('/api/danhmuc/nganh-nghe/bac-hoc');
  }

  Future<Response> postNganhNgheBacHoc(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/nganh-nghe/bac-hoc', data);
  }

  Future<Response> putNganhNgheBacHoc(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/nganh-nghe/bac-hoc', data);
  }

  Future<void> deleteNganhNgheBacHoc(String id) async {
    await _dio.delete('/api/danhmuc/nganh-nghe/bac-hoc/$id');
  }
}
