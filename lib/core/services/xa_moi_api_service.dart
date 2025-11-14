import 'package:dio/dio.dart';
import 'package:ttld/core/constants/api_endpoints.dart';

class XaMoiApiService {
  final Dio _dio;

  XaMoiApiService(this._dio);

  Future<dynamic> getXaMoi({
    int page = 1,
    int limit = 100,
    String? search,
    int? matinh,
    bool? status,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
      };

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      if (matinh != null) {
        queryParams['matinh'] = matinh;
      }

      if (status != null) {
        queryParams['status'] = status;
      }

      final response = await _dio.get(
        '${ApiEndpoints.hanhChinh}/xamoi',
        queryParameters: queryParams,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
