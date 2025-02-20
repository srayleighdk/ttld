import 'package:dio/dio.dart';

class HinhThucDiaDiemApiService {
  final Dio _dio;

  HinhThucDiaDiemApiService(this._dio);

  Future<Response> getHinhThucDiaDiem() async {
    return await _dio.get('/api/danhmuc/hinh-thuc/dia-diem');
  }

  Future<Response> postHinhThucDiaDiem(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/hinh-thuc/dia-diem', data);
  }

  Future<Response> putHinhThucDiaDiem(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/hinh-thuc/dia-diem', data);
  }

  Future<void> deleteHinhThucDiaDiem(String id) async {
    await _dio.delete('/api/danhmuc/hinh-thuc/dia-diem/$id');
  }
}
