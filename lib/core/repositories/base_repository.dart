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
        return Exception('Lỗi kết nối. Vui lòng kiểm tra kết nối internet.');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;
        
        // For login-related errors (401, 403), show a consistent message
        if (statusCode == 401 || statusCode == 403) {
          return Exception('Tên đăng nhập hoặc mật khẩu không đúng');
        }

        final errorMessage = responseData is Map<String, dynamic>
            ? responseData['message'] ?? 'Đã xảy ra lỗi'
            : responseData?.toString() ?? 'Đã xảy ra lỗi';

        switch (statusCode) {
          case 400:
            return Exception('Yêu cầu không hợp lệ: $errorMessage');
          case 404:
            return Exception('Không tìm thấy tài nguyên: $errorMessage');
          case 409:
            return Exception('Xung đột: $errorMessage');
          case 500:
            return Exception('Lỗi máy chủ: $errorMessage');
          default:
            return Exception('Lỗi HTTP $statusCode: $errorMessage');
        }

      case DioExceptionType.cancel:
        return Exception('Yêu cầu đã bị hủy');

      case DioExceptionType.unknown:
        if (e.error != null && e.error.toString().contains('SocketException')) {
          return Exception('Không có kết nối internet');
        }
        return Exception('Tên đăng nhập hoặc mật khẩu không đúng');

      case DioExceptionType.badCertificate:
        return Exception('Chứng chỉ SSL không hợp lệ');

      default:
        return Exception('Tên đăng nhập hoặc mật khẩu không đúng');
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
      throw Exception('Tên đăng nhập hoặc mật khẩu không đúng');
    }
  }
}
