import 'package:dio/dio.dart';

class TrinhDoTinHocApiService {
  final Dio _dio;

  TrinhDoTinHocApiService(this._dio);

  Future<Response> getTrinhDoTinHoc() async {
    return await _dio.get('/danhmuc/trinh-do/tin-hoc');
  }

  Future<Response> postTrinhDoTinHoc(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/trinh-do/tin-hoc', data: data);
  }

  Future<Response> putTrinhDoTinHoc(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/trinh-do/tin-hoc', data: data);
  }

  Future<void> deleteTrinhDoTinHoc(String id) async {
    await _dio.delete('/danhmuc/trinh-do/tin-hoc', queryParameters: {
      'id': id,
    });
  }
}
