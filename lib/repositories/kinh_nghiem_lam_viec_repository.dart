import 'package:injectable/injectable.dart';
import 'package:ttld/core/services/kinh_nghiem_lam_viec_api_service.dart';
import 'package:ttld/models/kinh_nghiem_lam_viec.dart';

abstract class KinhNghiemLamViecRepository {
  Future<List<KinhNghiemLamViec>> getKinhNghiemLamViecs();
  Future<void> createKinhNghiem(KinhNghiemLamViec kinhNghiemLamViec);
  Future<void> updateKinhNghiem(KinhNghiemLamViec kinhNghiemLamViec);
  Future<void> deleteKinhNghiem(String id);
}

@Injectable(as: KinhNghiemLamViecRepository)
class KinhNghiemLamViecRepositoryImpl implements KinhNghiemLamViecRepository {
  final KinhNghiemLamViecApiService _apiService;

  KinhNghiemLamViecRepositoryImpl(this._apiService);

  @override
  Future<List<KinhNghiemLamViec>> getKinhNghiemLamViecs() async {
    return await _apiService.getKinhNghiem();
  }

  @override
  Future<void> createKinhNghiem(KinhNghiemLamViec kinhNghiem) async {
    await _apiService.createKinhNghiem(kinhNghiem);
  }

  @override
  Future<void> updateKinhNghiem(KinhNghiemLamViec kinhNghiem) async {
    await _apiService.updateKinhNghiem(kinhNghiem);
  }

  @override
  Future<void> deleteKinhNghiem(String id) async {
    await _apiService.deleteKinhNghiem(id);
  }
}
