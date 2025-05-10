import 'package:ttld/core/api_client.dart';
import 'package:ttld/models/kieuchapnoi_model.dart';

class KieuChapNoiRepository {
  final ApiClient _apiClient;

  KieuChapNoiRepository(this._apiClient);

  Future<List<KieuChapNoiModel>> getKieuChapNois() async {
    try {
      final response = await _apiClient.dio.get('/common/kieu-chapnoi');
      
      if (response.statusCode == 200) {
        // Check if data is in a 'data' field
        final dynamic responseData = response.data;
        final List<dynamic> data = responseData is Map && responseData.containsKey('data') 
          ? responseData['data'] as List 
          : responseData as List;
          
        return data.map((json) => KieuChapNoiModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}

