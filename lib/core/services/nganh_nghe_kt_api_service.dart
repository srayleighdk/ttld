import 'package:dio/dio.dart';

class NganhNgheKTApiService {
  final Dio _dio;

  NganhNgheKTApiService(this._dio);

  Future<Response> getNganhNgheKT() async {
    return await _dio.get('/api/danhmuc/nganh-nghe/kinh-te');
  }

  Future<Response> postNganhNgheKT(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/nganh-nghe/kinh-te', data);
  }

  Future<Response> putNganhNgheKT(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/nganh-nghe/kinh-te', data);
  }

  Future<void> deleteNganhNgheKT(String id) async {
    await _dio.delete('/api/danhmuc/nganh-nghe/kinh-te/$id');
  }
}
