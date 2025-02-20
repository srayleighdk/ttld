import 'package:dio/dio.dart';

class TrinhDoHocVanApiService {
  final Dio _dio;

  TrinhDoHocVanApiService(this._dio);

  Future<Response> getTrinhDoHocVan() async {
    return await _dio.get('/api/danhmuc/trinh-do/hoc-van');
  }

  Future<Response> postTrinhDoHocVan(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/trinh-do/hoc-van', data);
  }

  Future<Response> putTrinhDoHocVan(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/trinh-do/hoc-van', data);
  }

  Future<void> deleteTrinhDoHocVan(String id) async {
    await _dio.delete('/api/danhmuc/trinh-do/hoc-van/$id');
  }
}
