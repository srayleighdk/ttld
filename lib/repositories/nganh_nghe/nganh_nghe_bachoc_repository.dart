import 'package:ttld/core/services/nganh_nghe_bachoc_api_service.dart';
import 'package:ttld/models/nganh_nghe_bachoc.dart';

abstract class NganhNgheBacHocRepository {
  Future<List<NganhNgheBacHoc>> getNganhNgheBacHocs();
  Future<NganhNgheBacHoc> addNganhNgheBacHoc(NganhNgheBacHoc nganhNgheBacHoc);
  Future<NganhNgheBacHoc> updateNganhNgheBacHoc(NganhNgheBacHoc nganhNgheBacHoc);
  Future<void> deleteNganhNgheBacHoc(String id);
}

class NganhNgheBacHocRepositoryImpl implements NganhNgheBacHocRepository {
  final NganhNgheBacHocApiService nganhNgheBacHocApiService;

  NganhNgheBacHocRepositoryImpl({required this.nganhNgheBacHocApiService});

  @override
  Future<List<NganhNgheBacHoc>> getNganhNgheBacHocs() async {
    final response = await nganhNgheBacHocApiService.getNganhNgheBacHoc();
    return (response.data['data'] as List)
        .map((json) => NganhNgheBacHoc.fromJson(json))
        .toList();
  }

  @override
  Future<NganhNgheBacHoc> addNganhNgheBacHoc(NganhNgheBacHoc nganhNgheBacHoc) async {
    final response = await nganhNgheBacHocApiService.postNganhNgheBacHoc(nganhNgheBacHoc.toJson());
    return NganhNgheBacHoc.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<NganhNgheBacHoc> updateNganhNgheBacHoc(NganhNgheBacHoc nganhNgheBacHoc) async {
    final response = await nganhNgheBacHocApiService.putNganhNgheBacHoc(nganhNgheBacHoc.toJson());
    return NganhNgheBacHoc.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteNganhNgheBacHoc(String id) async {
    await nganhNgheBacHocApiService.deleteNganhNgheBacHoc(id);
  }
}
