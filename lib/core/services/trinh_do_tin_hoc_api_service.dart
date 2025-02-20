import 'package:dio/dio.dart';

class TrinhDoTinHocApiService {
  final Dio _dio;

  TrinhDoTinHocApiService(this._dio);

  Future<Response> getTrinhDoTinHoc() async {
    return await _dio.get('/api/danhmuc/trinh-do/tin-hoc');
  }

  Future<Response> postTrinhDoTinHoc(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/trinh-do/tin-hoc', data);
  }

  Future<Response> putTrinhDoTinHoc(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/trinh-do/tin-hoc', data);
  }

  Future<void> deleteTrinhDoTinHoc(String id) async {
    await _dio.delete('/api/danhmuc/trinh-do/tin-hoc/$id');
  }
}
