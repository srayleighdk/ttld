import 'package:dio/dio.dart';

class NganhNgheChuyenNganhApiService {
  final Dio _dio;

  NganhNgheChuyenNganhApiService(this._dio);

  Future<Response> getNganhNgheChuyenNganh() async {
    return await _dio.get('/danhmuc/nganh-nghe/chuyen-nganh');
  }

  Future<Response> postNganhNgheChuyenNganh(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/nganh-nghe/chuyen-nganh', data: data);
  }

  Future<Response> putNganhNgheChuyenNganh(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/nganh-nghe/chuyen-nganh', data: data);
  }

  Future<void> deleteNganhNgheChuyenNganh(String id) async {
    await _dio.delete('/danhmuc/nganh-nghe/chuyen-nganh',
        queryParameters: {'id': id});
  }
}
