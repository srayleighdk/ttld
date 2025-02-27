import 'package:your_app_name/core/services/muc_luong_api_service.dart'; // Replace with your actual import
import 'package:your_app_name/models/muc_luong_mm.dart'; // Replace with your actual import

class MucLuongRepository {
  final MucLuongApiService mucLuongApiService;

  MucLuongRepository({required this.mucLuongApiService});

  Future<List<MucLuongMM>> getMucLuongs() async {
    return await mucLuongApiService.getMucLuongs();
  }

  Future<MucLuongMM> createMucLuong(MucLuongMM mucLuong) async {
    return await mucLuongApiService.createMucLuong(mucLuong);
  }

  Future<MucLuongMM> updateMucLuong(MucLuongMM mucLuong) async {
    return await mucLuongApiService.updateMucLuong(mucLuong);
  }

  Future<void> deleteMucLuong(int id) async {
    return await mucLuongApiService.deleteMucLuong(id);
  }
}
