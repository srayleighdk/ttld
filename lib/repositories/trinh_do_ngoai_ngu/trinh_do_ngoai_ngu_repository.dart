import 'package:ttld/core/services/trinh_do_ngoai_ngu_api_service.dart';
import 'package:ttld/models/trinh_do_ngoai_ngu_model.dart';

abstract class TrinhDoNgoaiNguRepository {
  Future<List<TrinhDoNgoaiNgu>> getTrinhDoNgoaiNgus();
  Future<TrinhDoNgoaiNgu> addTrinhDoNgoaiNgu(TrinhDoNgoaiNgu trinhDoNgoaiNgu);
  Future<TrinhDoNgoaiNgu> updateTrinhDoNgoaiNgu(TrinhDoNgoaiNgu trinhDoNgoaiNgu);
  Future<void> deleteTrinhDoNgoaiNgu(String id);
}

class TrinhDoNgoaiNguRepositoryImpl implements TrinhDoNgoaiNguRepository {
  final TrinhDoNgoaiNguApiService trinhDoNgoaiNguApiService;

  TrinhDoNgoaiNguRepositoryImpl({required this.trinhDoNgoaiNguApiService});

  @override
  Future<List<TrinhDoNgoaiNgu>> getTrinhDoNgoaiNgus() async {
    final response = await trinhDoNgoaiNguApiService.getTrinhDoNgoaiNgu();
    return (response.data['data'] as List)
        .map((json) => TrinhDoNgoaiNgu.fromJson(json))
        .toList();
  }

  @override
  Future<TrinhDoNgoaiNgu> addTrinhDoNgoaiNgu(TrinhDoNgoaiNgu trinhDoNgoaiNgu) async {
    final response = await trinhDoNgoaiNguApiService.postTrinhDoNgoaiNgu(trinhDoNgoaiNgu.toJson());
    return TrinhDoNgoaiNgu.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<TrinhDoNgoaiNgu> updateTrinhDoNgoaiNgu(TrinhDoNgoaiNgu trinhDoNgoaiNgu) async {
    final response = await trinhDoNgoaiNguApiService.putTrinhDoNgoaiNgu(trinhDoNgoaiNgu.toJson());
    return TrinhDoNgoaiNgu.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteTrinhDoNgoaiNgu(String id) async {
    await trinhDoNgoaiNguApiService.deleteTrinhDoNgoaiNgu(id);
  }
}
