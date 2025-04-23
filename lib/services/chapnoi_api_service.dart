import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chapnoi/chapnoi_model.dart';
import '../models/api_response_list.dart'; // Assuming you have a generic list response model
import '../models/api_response_object.dart'; // Assuming you have a generic object response model

class ChapNoiApiService {
  final Dio _dio;
  final String? _baseUrl = dotenv.env['BASE_URL'];

  ChapNoiApiService(this._dio) {
    _dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.connectTimeout = const Duration(milliseconds: 10000); // 10 seconds
    _dio.options.receiveTimeout = const Duration(milliseconds: 10000); // 10 seconds
  }

  Future<void> _setAuthorizationHeader() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

  Future<ApiResponseList<ChapNoiModel>> getChapNoiList({
    required int limit,
    required int page,
    int? status,
    String? idTuyenDung,
    String? idDoanhNghiep,
  }) async {
    await _setAuthorizationHeader();
    final url = '$_baseUrl/api/nghiep-vu/chapnoi';
    try {
      final queryParameters = <String, dynamic>{
        'limit': limit,
        'page': page,
      };
      if (status != null) queryParameters['status'] = status;
      if (idTuyenDung != null) queryParameters['idTuyenDung'] = idTuyenDung;
      if (idDoanhNghiep != null) queryParameters['idDoanhNghiep'] = idDoanhNghiep;

      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        // Assuming the API returns a structure like { data: [...], total: ... }
        // Adjust parsing based on your actual API response structure
        final List<dynamic> data = response.data['data'] ?? [];
        final int total = response.data['total'] ?? 0;
        final chapNoiList = data.map((json) => ChapNoiModel.fromJson(json)).toList();
        return ApiResponseList<ChapNoiModel>(
          data: chapNoiList,
          total: total,
          message: 'Success', // Or parse from response if available
        );
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to load ChapNoi list: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      print('DioException fetching ChapNoi list: ${e.message}');
      print('Response data: ${e.response?.data}');
      throw Exception('Failed to load ChapNoi list: ${e.message}');
    } catch (e) {
      print('Error fetching ChapNoi list: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<ApiResponseObject<ChapNoiModel>> createChapNoi(ChapNoiModel chapNoi) async {
    await _setAuthorizationHeader();
    final url = '$_baseUrl/api/nghiep-vu/chapnoi';
    try {
      final response = await _dio.post(
        url,
        data: chapNoi.toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) { // Check for 201 Created or 200 OK
        // Assuming the API returns the created object in the 'data' field
        // Adjust parsing based on your actual API response structure
        final createdChapNoi = ChapNoiModel.fromJson(response.data['data']);
         return ApiResponseObject<ChapNoiModel>(
          data: createdChapNoi,
          message: response.data['message'] ?? 'ChapNoi created successfully',
        );
      } else {
         throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to create ChapNoi: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      print('DioException creating ChapNoi: ${e.message}');
      print('Response data: ${e.response?.data}');
      // Try to parse error message from response
      String errorMessage = 'Failed to create ChapNoi: ${e.message}';
      if (e.response?.data is Map && e.response!.data.containsKey('message')) {
        errorMessage = e.response!.data['message'];
      }
      throw Exception(errorMessage);
    } catch (e) {
       print('Error creating ChapNoi: $e');
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
