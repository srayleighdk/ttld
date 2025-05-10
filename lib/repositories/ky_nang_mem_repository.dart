import 'package:ttld/models/ky_nang_mem_model.dart';
import 'package:ttld/services/api/ky_nang_mem_api_service.dart';

class KyNangMemRepository {
  final KyNangMemApiService _apiService;

  KyNangMemRepository(this._apiService);

  Future<List<KyNangMemModel>> getKyNangMems() async {
    try {
      final response = await _apiService.getKyNangMem();
      return (response.data['data'] as List)
          .map((json) => KyNangMemModel.fromJson(json))
          .toList();
    } catch (e) {
      // Handle or rethrow the error appropriately
      print('Error fetching KyNangMems: $e');
      rethrow;
    }
  }

  Future<KyNangMemModel> addKyNangMem(KyNangMemModel kyNangMem) async {
    try {
      final response = await _apiService.postKyNangMem(kyNangMem);
      return response.data['data'] as KyNangMemModel;
    } catch (e) {
      print('Error adding KyNangMem: $e');
      rethrow;
    }
  }

  Future<KyNangMemModel> updateKyNangMem(KyNangMemModel kyNangMem) async {
    try {
      // Ensure the model has an ID for updating
      if (kyNangMem.id == null) {
        throw ArgumentError('KyNangMemModel must have an ID to be updated.');
      }
      final response = await _apiService.putKyNangMem(kyNangMem);
      return response.data['data'] as KyNangMemModel;
    } catch (e) {
      print('Error updating KyNangMem: $e');
      rethrow;
    }
  }

  Future<void> deleteKyNangMem(int id) async {
    try {
      // Using Option 3 (ID in body) as per the ApiService definition
      await _apiService.deleteKyNangMem(id.toString());
    } catch (e) {
      print('Error deleting KyNangMem: $e');
      rethrow;
    }
  }
}
