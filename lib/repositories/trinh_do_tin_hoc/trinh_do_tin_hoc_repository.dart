import 'package:ttld/core/services/trinh_do_tin_hoc_api_service.dart';
import 'package:ttld/models/trinh_do_tin_hoc_model.dart';

abstract class TrinhDoTinHocRepository {
  Future<List<TrinhDoTinHoc>> getTrinhDoTinHocs();
  Future<TrinhDoTinHoc> addTrinhDoTinHoc(TrinhDoTinHoc trinhDoTinHoc);
  Future<TrinhDoTinHoc> updateTrinhDoTinHoc(TrinhDoTinHoc trinhDoTinHoc);
  Future<void> deleteTrinhDoTinHoc(String id);
}

class TrinhDoTinHocRepositoryImpl implements TrinhDoTinHocRepository {
  final TrinhDoTinHocApiService trinhDoTinHocApiService;

  TrinhDoTinHocRepositoryImpl(this.trinhDoTinHocApiService);

  @override
  Future<List<TrinhDoTinHoc>> getTrinhDoTinHocs() async {
    final response = await trinhDoTinHocApiService.getTrinhDoTinHoc();
    return (response.data['data'] as List)
        .map((json) => TrinhDoTinHoc.fromJson(json))
        .toList();
  }

  @override
  Future<TrinhDoTinHoc> addTrinhDoTinHoc(TrinhDoTinHoc trinhDoTinHoc) async {
    final response =
        await trinhDoTinHocApiService.postTrinhDoTinHoc(trinhDoTinHoc.toJson());
    return TrinhDoTinHoc.fromJson(
        response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<TrinhDoTinHoc> updateTrinhDoTinHoc(TrinhDoTinHoc trinhDoTinHoc) async {
    final response =
        await trinhDoTinHocApiService.putTrinhDoTinHoc(trinhDoTinHoc.toJson());
    return TrinhDoTinHoc.fromJson(
        response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteTrinhDoTinHoc(String id) async {
    await trinhDoTinHocApiService.deleteTrinhDoTinHoc(id);
  }
}
