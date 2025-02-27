import 'package:your_app_name/core/services/muc_luong_api_service.dart';
import 'package:your_app_name/models/muc_luong_mm.dart';

abstract class MucLuongRepository {
  Future<List<MucLuongMM>> getMucLuongs();
  Future<MucLuongMM> addMucLuong(MucLuongMM mucLuong);
  Future<MucLuongMM> updateMucLuong(MucLuongMM mucLuong);
  Future<void> deleteMucLuong(int id);
}

class MucLuongRepositoryImpl implements MucLuongRepository {
  final MucLuongApiService mucLuongApiService;

  MucLuongRepositoryImpl({required this.mucLuongApiService});

  @override
  Future<List<MucLuongMM>> getMucLuongs() async {
    final response = await mucLuongApiService.getMucLuongs();
    return response;
  }

  @override
  Future<MucLuongMM> addMucLuong(MucLuongMM mucLuong) async {
    final response = await mucLuongApiService.createMucLuong(mucLuong);
    return response;
  }

  @override
  Future<MucLuongMM> updateMucLuong(MucLuongMM mucLuong) async {
    final response = await mucLuongApiService.updateMucLuong(mucLuong);
    return response;
  }

  @override
  Future<void> deleteMucLuong(int id) async {
    await mucLuongApiService.deleteMucLuong(id);
  }
}
