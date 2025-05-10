import 'package:injectable/injectable.dart';
import 'package:ttld/core/services/kinh_nghiem_lam_viec_api_service.dart';
import 'package:ttld/models/kinh_nghiem_lam_viec.dart';

abstract class KinhNghiemLamViecRepository {
  Future<List<KinhNghiemLamViec>> getKinhNghiemLamViecList();
  Future<void> createKinhNghiem(KinhNghiemLamViec kinhNghiemLamViec);
  Future<void> updateKinhNghiem(KinhNghiemLamViec kinhNghiemLamViec);
  Future<void> deleteKinhNghiem(String id);
}

@Injectable(as: KinhNghiemLamViecRepository)
class KinhNghiemLamViecRepositoryImpl implements KinhNghiemLamViecRepository {
  final KinhNghiemLamViecApiService _apiService;

  KinhNghiemLamViecRepositoryImpl(this._apiService);

  @override
  Future<List<KinhNghiemLamViec>> getKinhNghiemLamViecList() async {
    try {
      return await _apiService.getKinhNghiem();
    } catch (e) {
      print('Error fetching KinhNghiemLamViec list: $e');
      rethrow;
    }
  }

  @override
  Future<void> createKinhNghiem(KinhNghiemLamViec kinhNghiem) async {
    try {
      await _apiService.createKinhNghiem(kinhNghiem);
    } catch (e) {
      print('Error creating KinhNghiemLamViec: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateKinhNghiem(KinhNghiemLamViec kinhNghiem) async {
    try {
      await _apiService.updateKinhNghiem(kinhNghiem);
    } catch (e) {
      print('Error updating KinhNghiemLamViec: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteKinhNghiem(String id) async {
    try {
      await _apiService.deleteKinhNghiem(id);
    } catch (e) {
      print('Error deleting KinhNghiemLamViec: $e');
      rethrow;
    }
  }
}
