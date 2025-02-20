import 'package:dio/dio.dart';

class NganhNgheApiService {
  final Dio _dio;

  NganhNgheApiService(this._dio);

  Future<Response> getNganhNghe() async {
    return await _dio.get('/api/danhmuc/nganh-nghe/kinh-te');
  }

  Future<Response> postNganhNghe(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/nganh-nghe/kinh-te', data);
  }

  Future<Response> putNganhNghe(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/nganh-nghe/kinh-te', data);
  }

  Future<void> deleteNganhNghe(String id) async {
    await _dio.delete('/api/danhmuc/nganh-nghe/kinh-te/$id');
  }
}
