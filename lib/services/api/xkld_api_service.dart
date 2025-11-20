import 'package:dio/dio.dart';
import 'package:ttld/core/api_client.dart';
import 'package:ttld/models/hoso_xkld/hoso_xkld_model.dart';

class XKLDApiService {
  final ApiClient _apiClient;

  XKLDApiService(this._apiClient);

  /// Get prefill data from candidate profile
  Future<HosoXKLDModel?> getPrefillData() async {
    try {
      print('📡 Calling API: /nghiep-vu/hoso-xkld/prefill');
      final response = await _apiClient.get('/nghiep-vu/hoso-xkld/prefill');
      print('📥 Response status: ${response.statusCode}');
      print('📥 Response data: ${response.data}');
      
      if (response.data['success'] == true && response.data['data'] != null) {
        print('✅ Parsing prefill data...');
        return HosoXKLDModel.fromJson(response.data['data']);
      }
      print('⚠️ No data in response or success=false');
      return null;
    } catch (e) {
      print('❌ Error getting prefill data: $e');
      rethrow;
    }
  }

  /// Save draft to server
  Future<Map<String, dynamic>> saveDraft(HosoXKLDModel data) async {
    try {
      final response = await _apiClient.post(
        '/nghiep-vu/hoso-xkld/draft',
        data: data.toJson(),
      );
      return response.data;
    } catch (e) {
      print('Error saving draft to server: $e');
      rethrow;
    }
  }

  /// Get draft from server
  Future<HosoXKLDModel?> getDraft(String id) async {
    try {
      final response = await _apiClient.get('/nghiep-vu/hoso-xkld/draft/$id');
      if (response.data['success'] == true && response.data['data'] != null) {
        return HosoXKLDModel.fromJson(response.data['data']);
      }
      return null;
    } catch (e) {
      print('Error getting draft from server: $e');
      rethrow;
    }
  }

  /// Submit final XKLD application
  Future<Map<String, dynamic>> submitApplication(HosoXKLDModel data) async {
    try {
      final response = await _apiClient.post(
        '/nghiep-vu/hoso-xkld',
        data: data.toJson(),
      );
      return response.data;
    } catch (e) {
      print('Error submitting application: $e');
      rethrow;
    }
  }

  /// Get XKLD list
  Future<Map<String, dynamic>> getXKLDList({
    int? page,
    int? limit,
    String? tungay,
    String? denngay,
  }) async {
    try {
      final response = await _apiClient.get(
        '/nghiep-vu/hoso-xkld',
        queryParameters: {
          if (page != null) 'page': page,
          if (limit != null) 'limit': limit,
          if (tungay != null) 'tungay': tungay,
          if (denngay != null) 'denngay': denngay,
        },
      );
      return response.data;
    } catch (e) {
      print('Error getting XKLD list: $e');
      rethrow;
    }
  }

  /// Update XKLD
  Future<Map<String, dynamic>> updateXKLD(
    String id,
    HosoXKLDModel data,
  ) async {
    try {
      final response = await _apiClient.put(
        '/nghiep-vu/hoso-xkld?id=$id',
        data: data.toJson(),
      );
      return response.data;
    } catch (e) {
      print('Error updating XKLD: $e');
      rethrow;
    }
  }

  /// Delete XKLD
  Future<Map<String, dynamic>> deleteXKLD(String id) async {
    try {
      final response = await _apiClient.delete(
        '/nghiep-vu/hoso-xkld?id=$id',
      );
      return response.data;
    } catch (e) {
      print('Error deleting XKLD: $e');
      rethrow;
    }
  }
}
