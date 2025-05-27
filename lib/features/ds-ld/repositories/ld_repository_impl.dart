import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart'; // Import GetIt
import 'package:ttld/core/api_client.dart';
import 'package:ttld/core/constants/api_endpoints.dart';
import 'package:ttld/core/models/paginated_reponse.dart';
import 'package:ttld/core/repositories/base_repository.dart';
import 'package:ttld/features/ds-ld/models/ld.dart';
import 'package:ttld/features/ds-ld/repositories/ld_repository.dart';

final locator = GetIt.instance; // Get the locator instance

class LdRepositoryImpl extends BaseRepository implements LdRepository {
  final Dio _dio;

  // Constructor injection
  LdRepositoryImpl(this._dio);

  // Named constructor using ApiClient singleton
  LdRepositoryImpl.withDefaultDio() : _dio = locator<ApiClient>().dio; // Use locator

  @override
  Future<LdModel> getLd(String id) async {
    try {
      final response = await _dio.get('${ApiEndpoints.ld}/$id');
      return LdModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to fetch LD: $e');
    }
  }

  @override
  Future<PaginatedResponse<LdModel>> getLds({
    int page = 1,
    int limit = 10,
    Map<String, dynamic>? filters,
  }) async {
    return safeApiCall(() async {
      final response = await dio.get(
        ApiEndpoints.ld,
        queryParameters: {
          'page': page,
          'limit': limit,
          if (filters != null) ...filters,
        },
      );

      return PaginatedResponse.fromJson(
        response.data,
        (json) => LdModel.fromJson(json),
      );
    });
  }

  @override
  Future<void> createLd(LdModel ld) async {
    try {
      await _dio.post(
        ApiEndpoints.ld,
        data: ld.toJson(),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to create LD: $e');
    }
  }

  @override
  Future<void> updateLd(LdModel ld) async {
    try {
      await _dio.put(
        '${ApiEndpoints.ld}/${ld.maphieu}',
        data: ld.toJson(),
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to update LD: $e');
    }
  }

  @override
  Future<void> deleteLd(String id) async {
    try {
      await _dio.delete('${ApiEndpoints.ld}/$id');
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to delete LD: $e');
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception(
            'Connection timeout. Please check your internet connection.');

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final errorMessage =
            e.response?.data['message'] ?? 'Unknown error occurred';

        switch (statusCode) {
          case 400:
            return Exception('Invalid request: $errorMessage');
          case 401:
            return Exception('Unauthorized: $errorMessage');
          case 403:
            return Exception('Forbidden: $errorMessage');
          case 404:
            return Exception('LD not found: $errorMessage');
          case 409:
            return Exception('Conflict: $errorMessage');
          case 500:
            return Exception('Server error: $errorMessage');
          default:
            return Exception('HTTP Error $statusCode: $errorMessage');
        }

      case DioExceptionType.cancel:
        return Exception('Request was cancelled');

      case DioExceptionType.unknown:
        if (e.error != null && e.error.toString().contains('SocketException')) {
          return Exception('No internet connection');
        }
        return Exception('An unexpected error occurred: ${e.error}');

      default:
        return Exception('Network error occurred: ${e.message}');
    }
  }
}
