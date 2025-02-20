import 'package:dio/dio.dart';

class HinhThucDoanhNghiepApiService {
  final Dio _dio;

  HinhThucDoanhNghiepApiService(this._dio);

  Future<Response> getHinhThucDoanhNghiep() async {
    return await _dio.get('/api/danhmuc/hinh-thuc/doanh-nghiep');
  }

  Future<Response> postHinhThucDoanhNghiep(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/hinh-thuc/doanh-nghiep', data);
  }

  Future<Response> putHinhThucDoanhNghiep(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/hinh-thuc/doanh-nghiep', data);
  }

  Future<void> deleteHinhThucDoanhNghiep(String id) async {
    await _dio.delete('/api/danhmuc/hinh-thuc/doanh-nghiep/$id');
  }
}
