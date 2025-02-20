import 'package:dio/dio.dart';

class NganhNgheChuyenNganhApiService {
  final Dio _dio;

  NganhNgheChuyenNganhApiService(this._dio);

  Future<Response> getNganhNgheChuyenNganh() async {
    return await _dio.get('/api/danhmuc/nganh-nghe/chuyen-nganh');
  }

  Future<Response> postNganhNgheChuyenNganh(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/nganh-nghe/chuyen-nganh', data);
  }

  Future<Response> putNganhNgheChuyenNganh(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/nganh-nghe/chuyen-nganh', data);
  }

  Future<void> deleteNganhNgheChuyenNganh(String id) async {
    await _dio.delete('/api/danhmuc/nganh-nghe/chuyen-nganh/$id');
  }
}
