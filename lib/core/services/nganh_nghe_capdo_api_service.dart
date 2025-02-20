import 'package:dio/dio.dart';

class NganhNgheCapDoApiService {
  final Dio _dio;

  NganhNgheCapDoApiService(this._dio);

  Future<Response> getNganhNgheCapDo() async {
    return await _dio.get('/api/danhmuc/nganh-nghe/cap-do');
  }

  Future<Response> postNganhNgheCapDo(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/nganh-nghe/cap-do', data);
  }

  Future<Response> putNganhNgheCapDo(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/nganh-nghe/cap-do', data);
  }

  Future<void> deleteNganhNgheCapDo(String id) async {
    await _dio.delete('/api/danhmuc/nganh-nghe/cap-do/$id');
  }
}
