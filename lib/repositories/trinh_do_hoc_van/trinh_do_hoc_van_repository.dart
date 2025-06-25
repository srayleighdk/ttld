import 'package:ttld/core/services/trinh_do_hoc_van_api_service.dart';
import 'package:ttld/models/trinh_do_hoc_van_model.dart';

abstract class TrinhDoHocVanRepository {
  Future<List<TrinhDoHocVan>> getTrinhDoHocVans();
  Future<TrinhDoHocVan> addTrinhDoHocVan(TrinhDoHocVan trinhDoHocVan);
  Future<TrinhDoHocVan> updateTrinhDoHocVan(TrinhDoHocVan trinhDoHocVan);
  Future<void> deleteTrinhDoHocVan(String id);
}

class TrinhDoHocVanRepositoryImpl implements TrinhDoHocVanRepository {
  final TrinhDoHocVanApiService trinhDoHocVanApiService;

  TrinhDoHocVanRepositoryImpl(this.trinhDoHocVanApiService);

  @override
  Future<List<TrinhDoHocVan>> getTrinhDoHocVans() async {
    final response = await trinhDoHocVanApiService.getTrinhDoHocVan();
    return (response.data['data'] as List)
        .map((json) => TrinhDoHocVan.fromJson(json))
        .toList();
  }

  @override
  Future<TrinhDoHocVan> addTrinhDoHocVan(TrinhDoHocVan trinhDoHocVan) async {
    final response =
        await trinhDoHocVanApiService.postTrinhDoHocVan(trinhDoHocVan.toJson());
    return TrinhDoHocVan.fromJson(
        response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<TrinhDoHocVan> updateTrinhDoHocVan(TrinhDoHocVan trinhDoHocVan) async {
    final response =
        await trinhDoHocVanApiService.putTrinhDoHocVan(trinhDoHocVan.toJson());
    return TrinhDoHocVan.fromJson(
        response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteTrinhDoHocVan(String id) async {
    await trinhDoHocVanApiService.deleteTrinhDoHocVan(id);
  }
}
