import 'package:dio/dio.dart';
import 'package:ttld/models/uv_dk_sgd/uv_dk_sgd_model.dart';

abstract class UvDkSGDApiService {
  Future<List<UvDkSGD>> getUvDkSGDs(String userId);
  Future<UvDkSGD> registerForSGDVL(UvDkSGD registration);
}

class UvDkSGDApiServiceImpl implements UvDkSGDApiService {
  final Dio _dio;

  UvDkSGDApiServiceImpl(this._dio);

  @override
  Future<List<UvDkSGD>> getUvDkSGDs(String userId) async {
    try {
      final response = await _dio.get('/nghiep-vu/uv-dkyphien', queryParameters: {
        'userId': userId,
      });
      
      if (response.data is List) {
        return (response.data as List).map((json) => UvDkSGD.fromJson(json)).toList();
      } else if (response.data is Map<String, dynamic> && response.data['data'] is List) {
        return (response.data['data'] as List).map((json) => UvDkSGD.fromJson(json)).toList();
      }
      
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Failed to load UvDkSGD data: $e');
    }
  }

  @override
  Future<UvDkSGD> registerForSGDVL(UvDkSGD registration) async {
    try {
      final response = await _dio.post(
        '/nghiep-vu/uv-dkyphien',
        data: registration.toJson(),
      );
      
      if (response.data is Map<String, dynamic>) {
        final data = response.data['data'] ?? response.data;
        return UvDkSGD.fromJson(data);
      }
      
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Failed to register for SGDVL: $e');
    }
  }
} 