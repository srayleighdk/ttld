import 'package:dio/dio.dart';
import 'package:ttld/core/constants/api_endpoints.dart';
import 'package:ttld/models/sgdvl/sgdvl_model.dart';

class SGDVLApiService {
  SGDVLApiService(this.dio);

  final Dio dio;

  Future<List<SGDVL>> getSGDVLs() async {
    try {
      final response = await dio.get(ApiEndpoints.sgdvl);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => SGDVL.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load SGDVL: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load SGDVL: $e');
    }
  }
} 