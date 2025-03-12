import 'package:dio/dio.dart';

class DonViApiService {
  final Dio _dio;

  DonViApiService(this._dio);

  Future<Response> getDonVi() async {
    return await _dio.get('/danhmuc/don-vi');
  }

  Future<Response> postDonVi(Map<String, dynamic> data) async {
    return await _dio.post('/danhmuc/don-vi', data: data);
  }

  Future<Response> putDonVi(Map<String, dynamic> data) async {
    return await _dio.put('/danhmuc/don-vi', data: data);
  }

  Future<void> deleteDonVi(String id) async {
    await _dio.delete('/danhmuc/don-vi', queryParameters: {'id': id});
  }
}
