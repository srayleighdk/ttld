import 'package:ttld/core/services/hinh_thuc_lam_viec_api_service.dart';
import 'package:ttld/models/hinh_thuc_lam_viec_model.dart';

class HinhThucLamViecRepository {
  final HinhThucLamViecApiService _apiService;

  HinhThucLamViecRepository(this._apiService);

  Future<List<HinhThucLamViecModel>> getHinhThucLamViecs() async {
    try {
      final response = await _apiService.getHinhThucLamViec();
      return (response.data['data'] as List)
          .map((json) => HinhThucLamViecModel.fromJson(json))
          .toList();
    } catch (e) {
      print('Error fetching HinhThucLamViecs: $e');
      rethrow;
    }
  }

  Future<HinhThucLamViecModel> addHinhThucLamViec(
      HinhThucLamViecModel hinhThucLamViec) async {
    try {
      final response =
          await _apiService.postHinhThucLamViec(hinhThucLamViec.toJson());
      return HinhThucLamViecModel.fromJson(
          response.data['data'] as Map<String, dynamic>);
    } catch (e) {
      print('Error adding HinhThucLamViec: $e');
      rethrow;
    }
  }

  Future<HinhThucLamViecModel> updateHinhThucLamViec(
      HinhThucLamViecModel hinhThucLamViec) async {
    try {
      // Ensure the model has an ID for updating
      if (hinhThucLamViec.id == null) {
        throw ArgumentError(
            'HinhThucLamViecModel must have an ID to be updated.');
      }
      final response =
          await _apiService.putHinhThucLamViec(hinhThucLamViec.toJson());
      return HinhThucLamViecModel.fromJson(
          response.data['data'] as Map<String, dynamic>);
    } catch (e) {
      print('Error updating HinhThucLamViec: $e');
      rethrow;
    }
  }

  Future<void> deleteHinhThucLamViec(int id) async {
    try {
      // Using ID in body as per ApiService definition
      await _apiService.deleteHinhThucLamViec(id.toString());
    } catch (e) {
      print('Error deleting HinhThucLamViec: $e');
      rethrow;
    }
  }
}
