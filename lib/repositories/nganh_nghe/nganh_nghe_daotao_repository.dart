import 'package:ttld/core/services/nganh_nghe_daotao_api_service.dart';
import 'package:ttld/models/nganh_nghe_daotao.dart';

abstract class NganhNgheDaoTaoRepository {
  Future<List<NganhNgheDaoTao>> getNganhNgheDaoTaos();
  Future<NganhNgheDaoTao> addNganhNgheDaoTao(NganhNgheDaoTao nganhNgheDaoTao);
  Future<NganhNgheDaoTao> updateNganhNgheDaoTao(NganhNgheDaoTao nganhNgheDaoTao);
  Future<void> deleteNganhNgheDaoTao(String id);
}

class NganhNgheDaoTaoRepositoryImpl implements NganhNgheDaoTaoRepository {
  final NganhNgheDaoTaoApiService nganhNgheDaoTaoApiService;

  NganhNgheDaoTaoRepositoryImpl({required this.nganhNgheDaoTaoApiService});

  @override
  Future<List<NganhNgheDaoTao>> getNganhNgheDaoTaos() async {
    final response = await nganhNgheDaoTaoApiService.getNganhNgheDaoTao();
    return (response.data['data'] as List)
        .map((json) => NganhNgheDaoTao.fromJson(json))
        .toList();
  }

  @override
  Future<NganhNgheDaoTao> addNganhNgheDaoTao(NganhNgheDaoTao nganhNgheDaoTao) async {
    final response = await nganhNgheDaoTaoApiService.postNganhNgheDaoTao(nganhNgheDaoTao.toJson());
    return NganhNgheDaoTao.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<NganhNgheDaoTao> updateNganhNgheDaoTao(NganhNgheDaoTao nganhNgheDaoTao) async {
    final response = await nganhNgheDaoTaoApiService.putNganhNgheDaoTao(nganhNgheDaoTao.toJson());
    return NganhNgheDaoTao.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteNganhNgheDaoTao(String id) async {
    await nganhNgheDaoTaoApiService.deleteNganhNgheDaoTao(id);
  }
}
