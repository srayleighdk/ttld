import 'package:dio/dio.dart';

class LoaiHinhApiService {
  final Dio _dio;

  LoaiHinhApiService(this._dio);

  Future<Response> getLoaiHinh() async {
    return await _dio.get('/danhmuc/hinh-thuc/loai-hinh');
  }

  Future<Response> postLoaiHinh(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/hinh-thuc/loai-hinh', data: data);
  }

  Future<Response> putLoaiHinh(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/hinh-thuc/loai-hinh', data: data);
  }

  Future<void> deleteLoaiHinh(String id) async {
    await _dio
        .delete('/danhmuc/hinh-thuc/loai-hinh', queryParameters: {'id': id});
  }
}
