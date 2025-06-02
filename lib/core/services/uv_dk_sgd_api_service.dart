import 'package:dio/dio.dart';
import 'package:ttld/models/uv_dk_sgd/uv_dk_sgd_model.dart';

abstract class UvDkSGDApiService {
  Future<List<UvDkSGD>> getUvDkSGDs(String userId);
}

class UvDkSGDApiServiceImpl implements UvDkSGDApiService {
  final Dio _dio;

  UvDkSGDApiServiceImpl(this._dio);

  @override
  Future<List<UvDkSGD>> getUvDkSGDs(String userId) async {
    try {
      final response = await _dio.get('/nghiep-vu/uv-dkyphien');
      final dynamic data = response.data;
      
      // Log the response for debugging
      print('API Response: $data');
      print('Response type: ${data.runtimeType}');
      
      // Handle both List and Map responses
      if (data is List) {
        print('Processing as direct List response');
        return data.map((json) => UvDkSGD.fromJson(json)).toList();
      } else if (data is Map<String, dynamic>) {
        print('Processing as Map response');
        // Check for common response structures
        if (data.containsKey('data') && data['data'] is List) {
          print('Found data key with List data');
          return (data['data'] as List).map((json) => UvDkSGD.fromJson(json)).toList();
        }
      }
      throw Exception('Invalid response format. Expected List or Map with items/data/results key. Received: ${data.runtimeType}');
    } catch (e) {
      print('Error details: $e');
      throw Exception('Failed to load UvDkSGD data: $e');
    }
  }
} 