import 'package:ttld/core/services/muc_luong_api_service.dart';
import 'package:ttld/models/muc_luong_mm.dart';

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
    return (response.data['data'] as List)
        .map((json) => MucLuongMM.fromJson(json))
        .toList();
  }

  @override
  Future<MucLuongMM> addMucLuong(MucLuongMM mucLuong) async {
    final response = await mucLuongApiService.createMucLuong(mucLuong);
    return MucLuongMM.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<MucLuongMM> updateMucLuong(MucLuongMM mucLuong) async {
    final response = await mucLuongApiService.updateMucLuong(mucLuong);
    return MucLuongMM.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteMucLuong(int id) async {
    await mucLuongApiService.deleteMucLuong(id);
  }
}
