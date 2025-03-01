import 'package:dio/dio.dart';

class HinhThucDiaDiemApiService {
  final Dio _dio;

  HinhThucDiaDiemApiService(this._dio);

  Future<Response> getHinhThucDiaDiem() async {
    return await _dio.get('/danhmuc/hinh-thuc/dia-diem');
  }

  Future<Response> postHinhThucDiaDiem(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/hinh-thuc/dia-diem', data: data);
  }

  Future<Response> putHinhThucDiaDiem(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/hinh-thuc/dia-diem', data: data);
  }

  Future<void> deleteHinhThucDiaDiem(String id) async {
    await _dio.delete('/danhmuc/hinh-thuc/dia-diem', queryParameters: {
      'id': id,
    });
  }
}
