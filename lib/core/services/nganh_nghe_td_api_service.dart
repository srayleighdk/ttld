import 'package:dio/dio.dart';

class NganhNgheTDApiService {
  final Dio _dio;

  NganhNgheTDApiService(this._dio);

  Future<Response> getNganhNgheTD() async {
    return await _dio.get('/api/danhmuc/nganh-nghe/tuyen-dung');
  }

  Future<Response> postNganhNgheTD(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/nganh-nghe/tuyen-dung', data);
  }

  Future<Response> putNganhNgheTD(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/nganh-nghe/tuyen-dung', data);
  }

  Future<void> deleteNganhNgheTD(String manhom) async {
    await _dio.delete('/api/danhmuc/nganh-nghe/tuyen-dung/$manhom');
  }
}
