import 'package:injectable/injectable.dart';
import 'package:ttld/core/services/muc_dich_lam_viec_api_service.dart';
import 'package:ttld/models/muc_dich_lam_viec_model.dart';

abstract class MucDichLamViecRepository {
  Future<List<MucDichLamViec>> getMucDichLamViec();
  Future<void> createMucDichLamViec(MucDichLamViec mucDich);
  Future<void> updateMucDichLamViec(MucDichLamViec mucDich);
  Future<void> deleteMucDichLamViec(String id);
}

@Injectable(as: MucDichLamViecRepository)
class MucDichLamViecRepositoryImpl implements MucDichLamViecRepository {
  final MucDichLamViecApiService _apiService;

  MucDichLamViecRepositoryImpl(this._apiService);

  @override
  Future<List<MucDichLamViec>> getMucDichLamViec() async {
    return await _apiService.getMucDichLamViec();
  }

  @override
  Future<void> createMucDichLamViec(MucDichLamViec mucDich) async {
    await _apiService.createMucDichLamViec(mucDich);
  }

  @override
  Future<void> updateMucDichLamViec(MucDichLamViec mucDich) async {
    await _apiService.updateMucDichLamViec(mucDich);
  }

  @override
  Future<void> deleteMucDichLamViec(String id) async {
    await _apiService.deleteMucDichLamViec(id);
  }
}
