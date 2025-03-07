import 'package:injectable/injectable.dart';
import 'package:ttld/core/services/hinh_thuc_tuyen_dung_api_service.dart';
import 'package:ttld/models/hinh_thuc_tuyen_dung_model.dart';

abstract class HinhThucTuyenDungRepository {
  Future<List<HinhThucTuyenDung>> getHinhThucTuyenDung();
  Future<void> createHinhThucTuyenDung(HinhThucTuyenDung hinhThuc);
  Future<void> updateHinhThucTuyenDung(HinhThucTuyenDung hinhThuc);
  Future<void> deleteHinhThucTuyenDung(String id);
}

@Injectable(as: HinhThucTuyenDungRepository)
class HinhThucTuyenDungRepositoryImpl implements HinhThucTuyenDungRepository {
  final HinhThucTuyenDungApiService _apiService;

  HinhThucTuyenDungRepositoryImpl(this._apiService);

  @override
  Future<List<HinhThucTuyenDung>> getHinhThucTuyenDung() async {
    return await _apiService.getHinhThucTuyenDung();
  }

  @override
  Future<void> createHinhThucTuyenDung(HinhThucTuyenDung hinhThuc) async {
    await _apiService.createHinhThucTuyenDung(hinhThuc);
  }

  @override
  Future<void> updateHinhThucTuyenDung(HinhThucTuyenDung hinhThuc) async {
    await _apiService.updateHinhThucTuyenDung(hinhThuc);
  }

  @override
  Future<void> deleteHinhThucTuyenDung(String id) async {
    await _apiService.deleteHinhThucTuyenDung(id);
  }
}
