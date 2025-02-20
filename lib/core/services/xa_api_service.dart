import 'package:dio/dio.dart';
import 'package:ttld/core/constants/api_endpoints.dart';

class XaApiService {
  final Dio dio;

  XaApiService(this.dio);

  Future<dynamic> getXa() async {
    try {
      final response = await dio.get(ApiEndpoints.xa);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postXa(dynamic data) async {
    try {
      final response = await dio.post(ApiEndpoints.xa, data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> putXa(dynamic data) async {
    try {
      final response = await dio.put(ApiEndpoints.xa, data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteXa(String id) async {
    try {
      final response = await dio.delete('${ApiEndpoints.xa}/$id');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
