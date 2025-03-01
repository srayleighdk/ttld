import 'package:dio/dio.dart';

class TrinhDoHocVanApiService {
  final Dio _dio;

  TrinhDoHocVanApiService(this._dio);

  Future<Response> getTrinhDoHocVan() async {
    return await _dio.get('/danhmuc/trinh-do/hoc-van');
  }

  Future<Response> postTrinhDoHocVan(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/trinh-do/hoc-van', data: data);
  }

  Future<Response> putTrinhDoHocVan(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/trinh-do/hoc-van', data: data);
  }

  Future<void> deleteTrinhDoHocVan(String id) async {
    await _dio.delete('/danhmuc/trinh-do/hoc-van', queryParameters: {
      'id': id,
    });
  }
}
