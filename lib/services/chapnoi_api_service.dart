import 'package:dio/dio.dart';
import 'package:ttld/models/chapnoi/chapnoi_model.dart';
import 'package:ttld/models/api_response_list.dart';
import 'package:ttld/models/api_response_object.dart';

class ChapNoiApiService {
  final Dio _dio;
  // final String? _baseUrl = dotenv.env['BASE_URL']; // Removed

  ChapNoiApiService(this._dio); // Simplified constructor

  // Removed _setAuthorizationHeader method

  Future<ApiResponseList<ChapNoiModel>> getChapNoiList({
    int? limit,
    int? page,
    int? status,
    String? idTuyenDung,
    String? idDoanhNghiep,
    String? idUv,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (limit != null) queryParams['limit'] = limit.toString();
      if (page != null) queryParams['page'] = page.toString();
      if (status != null) queryParams['status'] = status.toString();
      if (idTuyenDung != null) queryParams['idTuyenDung'] = idTuyenDung;
      if (idDoanhNghiep != null) queryParams['idDoanhNghiep'] = idDoanhNghiep;
      if (idUv != null) queryParams['idUv'] = idUv;

      final response = await _dio.get(
        '/nghiep-vu/chapnoi',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return ApiResponseList<ChapNoiModel>.fromJson(
          response.data,
          (json) => ChapNoiModel.fromJson(json as Map<String, dynamic>),
        );
      } else {
        throw Exception('Failed to load ChapNoi list');
      }
    } catch (e) {
      throw Exception('Failed to load ChapNoi list: $e');
    }
  }

  Future<ApiResponseObject<ChapNoiModel>> createChapNoi(
      ChapNoiModel chapNoi) async {
    final url = '/nghiep-vu/chapnoi';
    try {
      // Log the request payload for debugging
      print('Creating ChapNoi with payload: ${chapNoi.toJson()}');

      final response = await _dio.post(
        url,
        data: chapNoi.toJson(),
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ApiResponseObject.fromJson(
          response.data,
          (json) => ChapNoiModel.fromJson(json as Map<String, dynamic>),
        );
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to create ChapNoi: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to create ChapNoi: ${e.message}';
      if (e.response?.data is Map && e.response!.data.containsKey('message')) {
        errorMessage = e.response!.data['message'];
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<ApiResponseObject<bool>> deleteChapNoi(String id) async {
    final url = '/nghiep-vu/chapnoi/$id';
    try {
      final response = await _dio.delete(url);

      if (response.statusCode == 200) {
        return ApiResponseObject.fromJson(
          response.data,
          (json) => json['success'] as bool,
        );
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Failed to delete ChapNoi: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to delete ChapNoi: ${e.message}';
      if (e.response?.data is Map && e.response!.data.containsKey('message')) {
        errorMessage = e.response!.data['message'];
      }
      throw Exception(errorMessage);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
