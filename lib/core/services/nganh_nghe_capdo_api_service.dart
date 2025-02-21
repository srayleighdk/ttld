import 'package:dio/dio.dart';

class NganhNgheCapDoApiService {
  final Dio _dio;

  NganhNgheCapDoApiService(this._dio);

  Future<Response> getNganhNgheCapDo() async {
    return await _dio.get('/danhmuc/nganh-nghe/cap-do');
  }

  Future<Response> postNganhNgheCapDo(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/nganh-nghe/cap-do', data: data);
  }

  Future<Response> putNganhNgheCapDo(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/nganh-nghe/cap-do', data: data);
  }

  Future<void> deleteNganhNgheCapDo(String id) async {
    await _dio
        .delete('/danhmuc/nganh-nghe/cap-do', queryParameters: {'id': id});
  }
}
