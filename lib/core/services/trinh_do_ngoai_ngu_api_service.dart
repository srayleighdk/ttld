import 'package:dio/dio.dart';

class TrinhDoNgoaiNguApiService {
  final Dio _dio;

  TrinhDoNgoaiNguApiService(this._dio);

  Future<Response> getTrinhDoNgoaiNgu() async {
    return await _dio.get('/api/danhmuc/trinh-do/ngoai-ngu');
  }

  Future<Response> postTrinhDoNgoaiNgu(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/trinh-do/ngoai-ngu', data);
  }

  Future<Response> putTrinhDoNgoaiNgu(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/trinh-do/ngoai-ngu', data);
  }

  Future<void> deleteTrinhDoNgoaiNgu(String id) async {
    await _dio.delete('/api/danhmuc/trinh-do/ngoai-ngu/$id');
  }
}
