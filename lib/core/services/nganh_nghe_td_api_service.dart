import 'package:dio/dio.dart';

class NganhNgheTDApiService {
  final Dio _dio;

  NganhNgheTDApiService(this._dio);

  Future<Response> getNganhNgheTD() async {
    return await _dio.get('/danhmuc/nganh-nghe/tuyen-dung');
  }

  Future<Response> postNganhNgheTD(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/nganh-nghe/tuyen-dung', data: data);
  }

  Future<Response> putNganhNgheTD(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/nganh-nghe/tuyen-dung', data: data);
  }

  Future<void> deleteNganhNgheTD(String id) async {
    await _dio
        .delete('/danhmuc/nganh-nghe/tuyen-dung/', queryParameters: {'id': id});
  }
}
