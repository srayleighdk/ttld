import 'package:dio/dio.dart';

class HinhThucDoanhNghiepApiService {
  final Dio _dio;

  HinhThucDoanhNghiepApiService(this._dio);

  Future<Response> getHinhThucDoanhNghiep() async {
    return await _dio.get('/danhmuc/hinh-thuc/doanh-nghiep');
  }

  Future<Response> postHinhThucDoanhNghiep(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/hinh-thuc/doanh-nghiep', data: data);
  }

  Future<Response> putHinhThucDoanhNghiep(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/hinh-thuc/doanh-nghiep', data: data);
  }

  Future<void> deleteHinhThucDoanhNghiep(String id) async {
    await _dio
        .delete('/danhmuc/hinh-thuc/doanh-nghiep', queryParameters: {'id': id});
  }
}
