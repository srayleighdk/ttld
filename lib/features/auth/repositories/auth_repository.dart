import 'package:dio/dio.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: request.toJson(),
      );
      if (response.statusCode == 201) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception(
            'Login failed: Unexpected status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Failed to login: $e');
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
        final Map<String, dynamic>? data = e.response?.data;

        switch (statusCode) {
          case 400:
            return Exception(data?['message'] ?? 'Invalid credentials');
          case 401:
            return Exception('Unauthorized access');
          case 403:
            return Exception('Access forbidden');
          case 404:
            return Exception('Service not found');
          case 500:
            return Exception('Internal server error');
          default:
            return Exception('Server error occurred');
        }

      case DioExceptionType.cancel:
        return Exception('Request cancelled');

      case DioExceptionType.unknown:
        if (e.error != null && e.error.toString().contains('SocketException')) {
          return Exception('No internet connection');
        }
        return Exception('An unexpected error occurred');

      default:
        return Exception('Network error occurred');
    }
  }
}
