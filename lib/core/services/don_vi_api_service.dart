import 'package:dio/dio.dart';

class DonViApiService {
  final Dio _dio;

  DonViApiService(this._dio);

  Future<Response> getDonVi() async {
    return await _dio.get('/api/danhmuc/don-vi');
  }

  Future<Response> postDonVi(Map<String, dynamic> data) async {
    return await _dio.post('/api/danhmuc/don-vi', data);
  }

  Future<Response> putDonVi(Map<String, dynamic> data) async {
    return await _dio.put('/api/danhmuc/don-vi', data);
  }

  Future<void> deleteDonVi(String id) async {
    await _dio.delete('/api/danhmuc/don-vi/$id');
  }
}
