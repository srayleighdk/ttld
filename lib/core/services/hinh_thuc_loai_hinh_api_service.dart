import 'package:dio/dio.dart';

class HinhThucLoaiHinhApiService {
  final Dio _dio;

  HinhThucLoaiHinhApiService(this._dio);

  Future<Response> getHinhThucLoaiHinh() async {
    return await _dio.get('/api/danhmuc/hinh-thuc/loai-hinh');
  }

  Future<Response> postHinhThucLoaiHinh(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/hinh-thuc/loai-hinh', data);
  }

  Future<Response> putHinhThucLoaiHinh(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/hinh-thuc/loai-hinh', data);
  }

  Future<void> deleteHinhThucLoaiHinh(String id) async {
    await _dio.delete('/api/danhmuc/hinh-thuc/loai-hinh/$id');
  }
}
