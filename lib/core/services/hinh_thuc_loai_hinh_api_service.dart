import 'package:dio/dio.dart';

class HinhThucLoaiHinhApiService {
  final Dio _dio;

  HinhThucLoaiHinhApiService(this._dio);

  Future<Response> getHinhThucLoaiHinh() async {
    return await _dio.get('/danhmuc/hinh-thuc/loai-hinh');
  }

  Future<Response> postHinhThucLoaiHinh(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/hinh-thuc/loai-hinh', data: data);
  }

  Future<Response> putHinhThucLoaiHinh(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/hinh-thuc/loai-hinh', data: data);
  }

  Future<void> deleteHinhThucLoaiHinh(String id) async {
    await _dio.delete('/danhmuc/hinh-thuc/loai-hinh', queryParameters: {
      'id': id,
    });
  }
}
