import 'package:ttld/models/ky_nang_mem_model.dart';
import 'package:ttld/services/api/ky_nang_mem_api_service.dart';

class KyNangMemRepository {
  final KyNangMemApiService _apiService;

  KyNangMemRepository(this._apiService);

  Future<List<KyNangMemModel>> getKyNangMems() async {
    try {
      return await _apiService.getKyNangMems();
    } catch (e) {
      // Handle or rethrow the error appropriately
      print('Error fetching KyNangMems: $e');
      rethrow;
    }
  }

  Future<KyNangMemModel> addKyNangMem(KyNangMemModel kyNangMem) async {
    try {
      return await _apiService.addKyNangMem(kyNangMem);
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
      return await _apiService.updateKyNangMem(kyNangMem);
    } catch (e) {
      print('Error updating KyNangMem: $e');
      rethrow;
    }
  }

  Future<void> deleteKyNangMem(int id) async {
    try {
      // Using Option 3 (ID in body) as per the ApiService definition
      await _apiService.deleteKyNangMem({'id': id});
    } catch (e) {
      print('Error deleting KyNangMem: $e');
      rethrow;
    }
  }
}
