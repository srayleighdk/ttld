import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttld/helppers/help.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late final Dio dio;

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  factory ApiClient() => _instance;

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: getEnv('API_BASE_URL'),
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
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

  Future<String?> getToken() async {
    if (kIsWeb || Platform.isLinux) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('auth_token');
    } else {
      return await storage.read(key: 'auth_token');
    }
  }

  Future<void> saveToken(String token) async {
    if (kIsWeb || Platform.isLinux) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
    } else {
      await storage.write(key: 'auth_token', value: token);
    }
  }

  Future<dynamic> getTinh() async {
    try {
      final response = await dio.get(ApiEndpoints.tinh);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postTinh(dynamic data) async {
    try {
      final response = await dio.post(ApiEndpoints.tinh,  data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> putTinh(dynamic data) async {
    try {
      final response = await dio.put(ApiEndpoints.tinh,  data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteTinh(String id) async {
    try {
      final response = await dio.delete('${ApiEndpoints.tinh}/$id');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
