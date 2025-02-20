import 'package:ttld/core/services/nganh_nghe_api_service.dart';
import 'package:ttld/models/nganh_nghe_td_model.dart';

abstract class NganhNgheTDRepository {
  Future<List<NganhNgheTD>> getNganhNgheTDs();
}

class NganhNgheTDRepositoryImpl implements NganhNgheTDRepository {
  final NganhNgheApiService nganhNgheApiService;

  NganhNgheTDRepositoryImpl({required this.nganhNgheApiService});

  @override
  Future<List<NganhNgheTD>> getNganhNgheTDs() async {
    final response = await nganhNgheApiService.getNganhNgheTD();
    return (response.data['data'] as List)
        .map((json) => NganhNgheTD.fromJson(json))
        .toList();
  }
}
