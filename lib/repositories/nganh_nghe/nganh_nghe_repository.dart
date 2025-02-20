import 'package:ttld/core/services/nganh_nghe_api_service.dart';
import 'package:ttld/models/nganh_nghe_model.dart';

abstract class NganhNgheRepository {
  Future<List<NganhNghe>> getNganhNghes();
  Future<NganhNghe> addNganhNghe(NganhNghe nganhNghe);
  Future<NganhNghe> updateNganhNghe(NganhNghe nganhNghe);
  Future<void> deleteNganhNghe(String id);
}

class NganhNgheRepositoryImpl implements NganhNgheRepository {
  final NganhNgheApiService nganhNgheApiService;

  NganhNgheRepositoryImpl({required this.nganhNgheApiService});

  @override
  Future<List<NganhNghe>> getNganhNghes() async {
    final response = await nganhNgheApiService.getNganhNghe();
    return (response.data['data'] as List)
        .map((json) => NganhNghe.fromJson(json))
        .toList();
  }

  @override
  Future<NganhNghe> addNganhNghe(NganhNghe nganhNghe) async {
    final response = await nganhNgheApiService.postNganhNghe(nganhNghe.toJson());
    return NganhNghe.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<NganhNghe> updateNganhNghe(NganhNghe nganhNghe) async {
    final response = await nganhNgheApiService.putNganhNghe(nganhNghe.toJson());
    return NganhNghe.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteNganhNghe(String id) async {
    await nganhNgheApiService.deleteNganhNghe(id);
  }
}
