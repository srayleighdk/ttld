import 'package:ttld/core/services/nganh_nghe_chuyennganh_api_service.dart';
import 'package:ttld/models/nganh_nghe_chuyennganh.dart';

abstract class NganhNgheChuyenNganhRepository {
  Future<List<NganhNgheChuyenNganh>> getNganhNgheChuyenNganhs();
  Future<NganhNgheChuyenNganh> addNganhNgheChuyenNganh(NganhNgheChuyenNganh nganhNgheChuyenNganh);
  Future<NganhNgheChuyenNganh> updateNganhNgheChuyenNganh(NganhNgheChuyenNganh nganhNgheChuyenNganh);
  Future<void> deleteNganhNgheChuyenNganh(String id);
}

class NganhNgheChuyenNganhRepositoryImpl implements NganhNgheChuyenNganhRepository {
  final NganhNgheChuyenNganhApiService nganhNgheChuyenNganhApiService;

  NganhNgheChuyenNganhRepositoryImpl({required this.nganhNgheChuyenNganhApiService});

  @override
  Future<List<NganhNgheChuyenNganh>> getNganhNgheChuyenNganhs() async {
    final response = await nganhNgheChuyenNganhApiService.getNganhNgheChuyenNganh();
    return (response.data['data'] as List)
        .map((json) => NganhNgheChuyenNganh.fromJson(json))
        .toList();
  }

  @override
  Future<NganhNgheChuyenNganh> addNganhNgheChuyenNganh(NganhNgheChuyenNganh nganhNgheChuyenNganh) async {
    final response = await nganhNgheChuyenNganhApiService.postNganhNgheChuyenNganh(nganhNgheChuyenNganh.toJson());
    return NganhNgheChuyenNganh.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<NganhNgheChuyenNganh> updateNganhNgheChuyenNganh(NganhNgheChuyenNganh nganhNgheChuyenNganh) async {
    final response = await nganhNgheChuyenNganhApiService.putNganhNgheChuyenNganh(nganhNgheChuyenNganh.toJson());
    return NganhNgheChuyenNganh.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteNganhNgheChuyenNganh(String id) async {
    await nganhNgheChuyenNganhApiService.deleteNganhNgheChuyenNganh(id);
  }
}
