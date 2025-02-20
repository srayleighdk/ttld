import 'package:ttld/core/services/hinh_thuc_dia_diem_api_service.dart';
import 'package:ttld/models/hinh_thuc_dia_diem_model.dart';

abstract class HinhThucDiaDiemRepository {
  Future<List<HinhThucDiaDiem>> getHinhThucDiaDiems();
  Future<HinhThucDiaDiem> addHinhThucDiaDiem(HinhThucDiaDiem hinhThucDiaDiem);
  Future<HinhThucDiaDiem> updateHinhThucDiaDiem(HinhThucDiaDiem hinhThucDiaDiem);
  Future<void> deleteHinhThucDiaDiem(String id);
}

class HinhThucDiaDiemRepositoryImpl implements HinhThucDiaDiemRepository {
  final HinhThucDiaDiemApiService hinhThucDiaDiemApiService;

  HinhThucDiaDiemRepositoryImpl({required this.hinhThucDiaDiemApiService});

  @override
  Future<List<HinhThucDiaDiem>> getHinhThucDiaDiems() async {
    final response = await hinhThucDiaDiemApiService.getHinhThucDiaDiem();
    return (response.data['data'] as List)
        .map((json) => HinhThucDiaDiem.fromJson(json))
        .toList();
  }

  @override
  Future<HinhThucDiaDiem> addHinhThucDiaDiem(HinhThucDiaDiem hinhThucDiaDiem) async {
    final response = await hinhThucDiaDiemApiService.postHinhThucDiaDiem(hinhThucDiaDiem.toJson());
    return HinhThucDiaDiem.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<HinhThucDiaDiem> updateHinhThucDiaDiem(HinhThucDiaDiem hinhThucDiaDiem) async {
    final response = await hinhThucDiaDiemApiService.putHinhThucDiaDiem(hinhThucDiaDiem.toJson());
    return HinhThucDiaDiem.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteHinhThucDiaDiem(String id) async {
    await hinhThucDiaDiemApiService.deleteHinhThucDiaDiem(id);
  }
}
