import 'package:ttld/core/services/nganh_nghe_capdo_api_service.dart';
import 'package:ttld/models/nganh_nghe_capdo.dart';

abstract class NganhNgheCapDoRepository {
  Future<List<NganhNgheCapDo>> getNganhNgheCapDos();
  Future<List<NganhNgheCapDo>> getNganhNgheCapDosByIdAndLevel(
      int? id, int? level);
  Future<NganhNgheCapDo> addNganhNgheCapDo(NganhNgheCapDo nganhNgheCapDo);
  Future<NganhNgheCapDo> updateNganhNgheCapDo(NganhNgheCapDo nganhNgheCapDo);
  Future<void> deleteNganhNgheCapDo(String id);
}

class NganhNgheCapDoRepositoryImpl implements NganhNgheCapDoRepository {
  final NganhNgheCapDoApiService nganhNgheCapDoApiService;

  NganhNgheCapDoRepositoryImpl({required this.nganhNgheCapDoApiService});

  @override
  Future<List<NganhNgheCapDo>> getNganhNgheCapDos() async {
    final response = await nganhNgheCapDoApiService.getNganhNgheCapDo();
    return (response.data['data'] as List)
        .map((json) => NganhNgheCapDo.fromJson(json))
        .toList();
  }

  @override
  Future<List<NganhNgheCapDo>> getNganhNgheCapDosByIdAndLevel(
      int? id, int? level) async {
    final response =
        await nganhNgheCapDoApiService.getNganhNgheCapDoByIdAndLevel(id, level);
    return (response.data['data'] as List)
        .map((json) => NganhNgheCapDo.fromJson(json))
        .toList();
  }

  @override
  Future<NganhNgheCapDo> addNganhNgheCapDo(
      NganhNgheCapDo nganhNgheCapDo) async {
    final response = await nganhNgheCapDoApiService
        .postNganhNgheCapDo(nganhNgheCapDo.toJson());
    return NganhNgheCapDo.fromJson(
        response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<NganhNgheCapDo> updateNganhNgheCapDo(
      NganhNgheCapDo nganhNgheCapDo) async {
    final response = await nganhNgheCapDoApiService
        .putNganhNgheCapDo(nganhNgheCapDo.toJson());
    return NganhNgheCapDo.fromJson(
        response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteNganhNgheCapDo(String id) async {
    await nganhNgheCapDoApiService.deleteNganhNgheCapDo(id);
  }
}
