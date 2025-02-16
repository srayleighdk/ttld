import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ttld/core/api_client.dart';

abstract class BaseRepository {
  final Dio dio = ApiClient().dio;

  Exception handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception(
            'Connection timeout. Please check your internet connection.');
      // ... rest of error handling
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;
        final errorMessage = responseData is Map<String, dynamic>
            ? responseData['message'] ?? 'Unknown error occurred'
            : responseData?.toString() ?? 'Unknown error occurred';

        switch (statusCode) {
          case 400:
            return Exception('Invalid request: $errorMessage');
          case 401:
            return Exception('Unauthorized: $errorMessage');
          case 403:
            return Exception('Forbidden: $errorMessage');
          case 404:
            return Exception('Resource not found: $errorMessage');
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

      case DioExceptionType.badCertificate:
        return Exception('Invalid SSL certificate');

      default:
        return Exception('Network error occurred: ${e.message}');
    }
  }

  Future<T> safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } on DioException catch (e) {
      debugPrint("DioException: ${e.toString()}");
      throw handleDioError(e);
    } catch (e, stackTrace) {
      debugPrint("Unhandled Error: $e");
      debugPrint(stackTrace.toString());
      throw Exception(e.toString());
    }
  }
}
