import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttld/core/enums/region.dart';
import 'package:ttld/features/auth/repositories/auth_repository.dart';
import 'package:ttld/helppers/help.dart'; // Assuming getEnv is here

class ApiClient {
  late final Dio _dio;
  final getIt = GetIt.instance;
  final SharedPreferences _prefs;

  ApiClient(this._prefs) {
    // Load base URL from SharedPreferences on initialization
    final savedRegionName = _prefs.getString('selected_region');
    final savedRegion = regionFromString(savedRegionName);
    final initialBaseUrl = getEnv(savedRegion?.baseUrlKey ??
        Region.lamDong.baseUrlKey); // Use default if none saved

    _dio = Dio(
      BaseOptions(
        baseUrl: initialBaseUrl, // Set initial base URL
        // baseUrl: 'http://localhost:3003/api',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await getIt<AuthRepository>().getTokenFromStorage();
          options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );

    if (!kIsWeb) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  Dio get dio => _dio;

  void setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Exception('Connection timeout');
        case DioExceptionType.sendTimeout:
          return Exception('Send timeout');
        case DioExceptionType.receiveTimeout:
          return Exception('Receive timeout');
        case DioExceptionType.badResponse:
          return Exception('Response error: ${error.response?.statusCode}');
        case DioExceptionType.cancel:
          return Exception('Request cancelled');
        case DioExceptionType.unknown:
          return Exception('Unknown error: ${error.message}');
        default:
          return Exception('Unknown error occurred');
      }
    }
    return Exception('Unexpected error: $error');
  }
}
