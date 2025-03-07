import 'package:injectable/injectable.dart';
import 'package:ttld/core/services/loai_hop_dong_lao_dong_api_service.dart';
import 'package:ttld/models/loai_hop_dong_lao_dong_model.dart';

abstract class LoaiHopDongLaoDongRepository {
  Future<List<LoaiHopDongLaoDong>> getLoaiHopDong();
  Future<void> createLoaiHopDong(LoaiHopDongLaoDong loaiHopDong);
  Future<void> updateLoaiHopDong(LoaiHopDongLaoDong loaiHopDong);
  Future<void> deleteLoaiHopDong(String id);
}

@Injectable(as: LoaiHopDongLaoDongRepository)
class LoaiHopDongLaoDongRepositoryImpl implements LoaiHopDongLaoDongRepository {
  final LoaiHopDongLaoDongApiService _apiService;

  LoaiHopDongLaoDongRepositoryImpl(this._apiService);

  @override
  Future<List<LoaiHopDongLaoDong>> getLoaiHopDong() async {
    return await _apiService.getLoaiHopDong();
  }

  @override
  Future<void> createLoaiHopDong(LoaiHopDongLaoDong loaiHopDong) async {
    await _apiService.createLoaiHopDong(loaiHopDong);
  }

  @override
  Future<void> updateLoaiHopDong(LoaiHopDongLaoDong loaiHopDong) async {
    await _apiService.updateLoaiHopDong(loaiHopDong);
  }

  @override
  Future<void> deleteLoaiHopDong(String id) async {
    await _apiService.deleteLoaiHopDong(id);
  }
}
