import 'package:dio/dio.dart';

class NganhNgheApiService {
  final Dio _dio;

  NganhNgheApiService(this._dio);

  Future<Response> getNganhNghe() async {
    return await _dio.get('/danhmuc/nganh-nghe/kinh-te');
  }

  Future<Response> postNganhNghe(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/nganh-nghe/kinh-te', data: data);
  }

  Future<Response> putNganhNghe(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/nganh-nghe/kinh-te', data: data);
  }

  Future<void> deleteNganhNghe(String id) async {
    await _dio
        .delete('/danhmuc/nganh-nghe/kinh-te', queryParameters: {'id': id});
  }
}
