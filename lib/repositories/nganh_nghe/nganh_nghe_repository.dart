import 'package:ttld/core/services/nganh_nghe_api_service.dart';
import 'package:ttld/models/nganh_nghe_model.dart';

abstract class NganhNgheRepository {
  Future<List<NganhNgheKT>> getNganhNghes();
  Future<NganhNgheKT> addNganhNghe(NganhNgheKT nganhNghe);
  Future<NganhNgheKT> updateNganhNghe(NganhNgheKT nganhNghe);
  Future<void> deleteNganhNghe(String id);
}

class NganhNgheRepositoryImpl implements NganhNgheRepository {
  final NganhNgheApiService nganhNgheApiService;

  NganhNgheRepositoryImpl({required this.nganhNgheApiService});

  @override
  Future<List<NganhNgheKT>> getNganhNghes() async {
    final response = await nganhNgheApiService.getNganhNghe();
    return (response.data['data'] as List)
        .map((json) => NganhNgheKT.fromJson(json))
        .toList();
  }

  @override
  Future<NganhNgheKT> addNganhNghe(NganhNgheKT nganhNghe) async {
    final response =
        await nganhNgheApiService.postNganhNghe(nganhNghe.toJson());
    return NganhNgheKT.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<NganhNgheKT> updateNganhNghe(NganhNgheKT nganhNghe) async {
    final response = await nganhNgheApiService.putNganhNghe(nganhNghe.toJson());
    return NganhNgheKT.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteNganhNghe(String id) async {
    await nganhNgheApiService.deleteNganhNghe(id);
  }
}
