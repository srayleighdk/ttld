import 'package:ttld/models/hinh_thuc_lam_viec_model.dart';
import 'package:ttld/services/api/hinh_thuc_lam_viec_api_service.dart';

class HinhThucLamViecRepository {
  final HinhThucLamViecApiService _apiService;

  HinhThucLamViecRepository(this._apiService);

  Future<List<HinhThucLamViecModel>> getHinhThucLamViecs() async {
    try {
      return await _apiService.getHinhThucLamViecs();
    } catch (e) {
      print('Error fetching HinhThucLamViecs: $e');
      rethrow;
    }
  }

  Future<HinhThucLamViecModel> addHinhThucLamViec(HinhThucLamViecModel hinhThucLamViec) async {
    try {
      return await _apiService.addHinhThucLamViec(hinhThucLamViec);
    } catch (e) {
      print('Error adding HinhThucLamViec: $e');
      rethrow;
    }
  }

  Future<HinhThucLamViecModel> updateHinhThucLamViec(HinhThucLamViecModel hinhThucLamViec) async {
    try {
      // Ensure the model has an ID for updating
      if (hinhThucLamViec.id == null) {
        throw ArgumentError('HinhThucLamViecModel must have an ID to be updated.');
      }
      return await _apiService.updateHinhThucLamViec(hinhThucLamViec);
    } catch (e) {
      print('Error updating HinhThucLamViec: $e');
      rethrow;
    }
  }

  Future<void> deleteHinhThucLamViec(int id) async {
    try {
      // Using ID in body as per ApiService definition
      await _apiService.deleteHinhThucLamViec({'id': id});
    } catch (e) {
      print('Error deleting HinhThucLamViec: $e');
      rethrow;
    }
  }
}
