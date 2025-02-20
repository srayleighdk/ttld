import 'package:dio/dio.dart';
import 'package:ttld/core/constants/api_endpoints.dart';

class TinhApiService {
  final Dio _dio;

  TinhApiService(this._dio); // Inject the Dio instance

  Future<dynamic> getTinh() async {
    try {
      final response = await _dio.get(ApiEndpoints.tinh);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postTinh(dynamic data) async {
    try {
      final response = await _dio.post(ApiEndpoints.tinh, data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> putTinh(dynamic data) async {
    try {
      final response = await _dio.put(ApiEndpoints.tinh, data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteTinh(String id) async {
    try {
      final response =
          await _dio.delete(ApiEndpoints.tinh, queryParameters: {'id': id});
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
