import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';
import 'package:ttld/helppers/help.dart';

class ApiClient {
  final Dio dio;
  final getIt = GetIt.instance;

  ApiClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: getEnv('API_BASE_URL'),
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // final token = await getToken();
          final token = await getIt<AuthRepository>().getTokenFromStorage();
          options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Handle success response (if needed)
          return handler.next(response);
        },
        onError: (error, handler) {
          // Handle error response (if needed)
          _handleError(error);
          return handler.next(error);
        },
      ),
    );

// Skip SSL verification
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    // Add interceptors for logging, token handling, etc.
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
        filter: (options, args) {
          // don't print requests with uris containing '/posts'
          if (options.path.contains('/posts')) {
            return false;
          }
          // don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        }));
  }

// Example GET request
  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      // Handle Dio errors
      throw _handleError(e);
    }
  }

  // Example POST request
  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      // Handle Dio errors
      throw _handleError(e);
    }
  }

  // Example PUT request
  Future<Response> put(String path, {dynamic data, Options? options}) async {
    try {
      final response = await dio.put(path, data: data, options: options);
      return response;
    } on DioException catch (e) {
      // Handle Dio errors
      throw _handleError(e);
    }
  }

  // Example DELETE request
  Future<Response> delete(String path) async {
    try {
      final response = await dio.delete(path);
      return response;
    } on DioException catch (e) {
      // Handle Dio errors
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        debugPrint('Connection timeout');
        return Exception('Connection timeout');
      case DioExceptionType.sendTimeout:
        debugPrint('Send timeout');
        return Exception('Send timeout');
      case DioExceptionType.receiveTimeout:
        debugPrint('Receive timeout');
        return Exception('Receive timeout');
      case DioExceptionType.badResponse:
        return _handleHttpError(error.response);
      case DioExceptionType.cancel:
        debugPrint('Request canceled');
        return Exception('Request canceled');
      case DioExceptionType.unknown:
        debugPrint('Unknown error: ${error.message}');
        return Exception('Unknown error: ${error.message}');
      default:
        debugPrint('Unhandled Dio error: ${error.type}');
        return Exception('Unhandled Dio error: ${error.type}');
    }
  }

  Exception _handleHttpError(Response? response) {
    if (response == null) {
      debugPrint('No response received');
      return Exception('No response received');
    }

    switch (response.statusCode) {
      case 400:
        debugPrint('Bad request: ${response.data}');
        return Exception('Bad request: ${response.data}');
      case 401:
        debugPrint('Unauthorized — Token may be invalid');
        return Exception('Unauthorized — Token may be invalid');
      case 403:
        debugPrint('Forbidden');
        return Exception('Forbidden');
      case 404:
        debugPrint('Not found: ${response.requestOptions.path}');
        return Exception('Not found: ${response.requestOptions.path}');
      case 500:
        return Exception('Internal server error');
      default:
        debugPrint('Unhandled HTTP error: ${response.statusCode}');
        return Exception('Unhandled HTTP error: ${response.statusCode}');
    }
  }
}
