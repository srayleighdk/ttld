import 'package:dio/dio.dart';
import 'package:ttld/models/dn_dk_pgd/dn_dk_pgd_model.dart';
import 'package:ttld/models/api_response_list.dart';
import 'package:ttld/models/api_response_object.dart';

class DnDkPgdService {
  final Dio _dio;

  DnDkPgdService(this._dio);

  Future<ApiResponseList<DnDkPgd>> getDnDkPgdList() async {
    try {
      final response = await _dio.get('/nghiep-vu/dn-dky');
      if (response.statusCode == 200) {
        return ApiResponseList.fromJson(
            response.data, (json) => DnDkPgd.fromJson(json));
      } else {
        throw Exception('Failed to load DN đăng ký: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load DN đăng ký: $e');
    }
  }

  Future<ApiResponseObject<DnDkPgd>> createDnDkPgd(DnDkPgd dnDkPgd) async {
    try {
      final response = await _dio.post(
        '/nghiep-vu/dn-dky',
        data: dnDkPgd.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = response.data['data'] as Map<String, dynamic>?;
        return ApiResponseObject(
          data: json != null ? DnDkPgd.fromJson(json) : null,
          message: response.data['message'] as String?,
          success: response.data['status'] as bool? ?? false,
        );
      } else {
        throw Exception('Failed to create DN đăng ký: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create DN đăng ký: $e');
    }
  }

  Future<ApiResponseObject<DnDkPgd>> updateDnDkPgd(DnDkPgd dnDkPgd) async {
    try {
      final response = await _dio.put(
        '/nghiep-vu/dn-dky',
        data: dnDkPgd.toJson(),
      );
      if (response.statusCode == 200) {
        final json = response.data['data'] as Map<String, dynamic>?;
        return ApiResponseObject(
          data: json != null ? DnDkPgd.fromJson(json) : null,
          message: response.data['message'] as String?,
          success: response.data['status'] as bool? ?? false,
        );
      } else {
        throw Exception('Failed to update DN đăng ký: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update DN đăng ký: $e');
    }
  }

  Future<ApiResponseObject<bool>> deleteDnDkPgd(String id) async {
    try {
      final response = await _dio.delete(
        '/nghiep-vu/dn-dky',
        data: {'id': id},
      );
      if (response.statusCode == 200) {
        return ApiResponseObject(
          data: response.data['data'] as bool? ?? false,
          message: response.data['message'] as String?,
          success: response.data['status'] as bool? ?? false,
        );
      } else {
        throw Exception('Failed to delete DN đăng ký: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete DN đăng ký: $e');
    }
  }
}
