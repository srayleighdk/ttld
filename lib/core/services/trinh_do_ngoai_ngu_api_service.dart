import 'package:dio/dio.dart';

class TrinhDoNgoaiNguApiService {
  final Dio _dio;

  TrinhDoNgoaiNguApiService(this._dio);

  Future<Response> getTrinhDoNgoaiNgu() async {
    return await _dio.get('/danhmuc/trinh-do/ngoai-ngu');
  }

  Future<Response> postTrinhDoNgoaiNgu(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/trinh-do/ngoai-ngu', data: data);
  }

  Future<Response> putTrinhDoNgoaiNgu(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/trinh-do/ngoai-ngu', data: data);
  }

  Future<void> deleteTrinhDoNgoaiNgu(String id) async {
    await _dio.delete('/danhmuc/trinh-do/ngoai-ngu', queryParameters: {
      'id': id,
    });
  }
}
