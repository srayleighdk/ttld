import 'package:ttld/core/services/trinh_do_van_hoa_api_service.dart';
import 'package:ttld/models/trinh_do_van_hoa_model.dart';

abstract class TrinhDoVanHoaRepository {
  Future<List<TrinhDoVanHoa>> getTrinhDoVanHoas();
  Future<TrinhDoVanHoa> addTrinhDoVanHoa(TrinhDoVanHoa trinhDoVanHoa);
  Future<TrinhDoVanHoa> updateTrinhDoVanHoa(TrinhDoVanHoa trinhDoVanHoa);
  Future<void> deleteTrinhDoVanHoa(String id);
}

class TrinhDoVanHoaRepositoryImpl implements TrinhDoVanHoaRepository {
  final TrinhDoVanHoaApiService trinhDoVanHoaApiService;

  TrinhDoVanHoaRepositoryImpl({required this.trinhDoVanHoaApiService});

  @override
  Future<List<TrinhDoVanHoa>> getTrinhDoVanHoas() async {
    final response = await trinhDoVanHoaApiService.getTrinhDoVanHoa();
    return (response.data['data'] as List)
        .map((json) => TrinhDoVanHoa.fromJson(json))
        .toList();
  }

  @override
  Future<TrinhDoVanHoa> addTrinhDoVanHoa(TrinhDoVanHoa trinhDoVanHoa) async {
    final response = await trinhDoVanHoaApiService.postTrinhDoVanHoa(trinhDoVanHoa.toJson());
    return TrinhDoVanHoa.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<TrinhDoVanHoa> updateTrinhDoVanHoa(TrinhDoVanHoa trinhDoVanHoa) async {
    final response = await trinhDoVanHoaApiService.putTrinhDoVanHoa(trinhDoVanHoa.toJson());
    return TrinhDoVanHoa.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteTrinhDoVanHoa(String id) async {
    await trinhDoVanHoaApiService.deleteTrinhDoVanHoa(id);
  }
}
