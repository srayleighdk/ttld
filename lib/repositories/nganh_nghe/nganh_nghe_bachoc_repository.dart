import 'package:ttld/core/services/nganh_nghe_bachoc_api_service.dart';
import 'package:ttld/models/nganh_nghe_bachoc.dart';

abstract class NganhNgheBacHocRepository {
  Future<List<TrinhDoChuyenMon>> getNganhNgheBacHocs();
  Future<TrinhDoChuyenMon> addNganhNgheBacHoc(TrinhDoChuyenMon nganhNgheBacHoc);
  Future<TrinhDoChuyenMon> updateNganhNgheBacHoc(
      TrinhDoChuyenMon nganhNgheBacHoc);
  Future<void> deleteNganhNgheBacHoc(String id);
}

class NganhNgheBacHocRepositoryImpl implements NganhNgheBacHocRepository {
  final NganhNgheBacHocApiService nganhNgheBacHocApiService;

  NganhNgheBacHocRepositoryImpl({required this.nganhNgheBacHocApiService});

  @override
  Future<List<TrinhDoChuyenMon>> getNganhNgheBacHocs() async {
    final response = await nganhNgheBacHocApiService.getNganhNgheBacHoc();
    return (response.data['data'] as List)
        .map((json) => TrinhDoChuyenMon.fromJson(json))
        .toList();
  }

  @override
  Future<TrinhDoChuyenMon> addNganhNgheBacHoc(
      TrinhDoChuyenMon nganhNgheBacHoc) async {
    final response = await nganhNgheBacHocApiService
        .postNganhNgheBacHoc(nganhNgheBacHoc.toJson());
    return TrinhDoChuyenMon.fromJson(
        response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<TrinhDoChuyenMon> updateNganhNgheBacHoc(
      TrinhDoChuyenMon nganhNgheBacHoc) async {
    final response = await nganhNgheBacHocApiService
        .putNganhNgheBacHoc(nganhNgheBacHoc.toJson());
    return TrinhDoChuyenMon.fromJson(
        response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteNganhNgheBacHoc(String id) async {
    await nganhNgheBacHocApiService.deleteNganhNgheBacHoc(id);
  }
}
