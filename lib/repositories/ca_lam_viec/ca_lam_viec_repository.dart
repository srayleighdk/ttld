import 'package:ttld/core/services/ca_lam_viec_api_service.dart';
import 'package:ttld/models/ca_lam_viec_model.dart';

abstract class CaLamViecRepository {
  Future<List<CaLamViec>> getCaLamViecs();
}

class CaLamViecRepositoryImpl implements CaLamViecRepository {
  final CaLamViecApiService caLamViecApiService;

  CaLamViecRepositoryImpl({required this.caLamViecApiService});

  @override
  Future<List<CaLamViec>> getCaLamViecs() async {
    final response = await caLamViecApiService.getCaLamViecs();
    return (response.data['data'] as List)
        .map((json) => CaLamViec.fromJson(json))
        .toList();
  }
}
