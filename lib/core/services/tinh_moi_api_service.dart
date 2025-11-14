import 'package:dio/dio.dart';
import 'package:ttld/core/constants/api_endpoints.dart';

class TinhMoiApiService {
  final Dio _dio;

  TinhMoiApiService(this._dio);

  Future<dynamic> getTinhMoi({
    int page = 1,
    int limit = 100,
    String? search,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final response = await _dio.get(
        '${ApiEndpoints.hanhChinh}/tinhmoi',
        queryParameters: queryParams,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
