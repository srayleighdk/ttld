import 'package:dio/dio.dart';

class NganhNgheBacHocApiService {
  final Dio _dio;

  NganhNgheBacHocApiService(this._dio);

  Future<Response> getNganhNgheBacHoc() async {
    return await _dio.get('/danhmuc/nganh-nghe/bac-hoc');
  }

  Future<Response> postNganhNgheBacHoc(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/nganh-nghe/bac-hoc', data: data);
  }

  Future<Response> putNganhNgheBacHoc(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/nganh-nghe/bac-hoc', data: data);
  }

  Future<void> deleteNganhNgheBacHoc(String id) async {
    await _dio
        .delete('/danhmuc/nganh-nghe/bac-hoc', queryParameters: {'id': id});
  }
}
