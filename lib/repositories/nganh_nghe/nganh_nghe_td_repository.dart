import 'package:ttld/core/services/nganh_nghe_td_api_service.dart';
import 'package:ttld/models/nganh_nghe_td_model.dart';

abstract class NganhNgheTDRepository {
  Future<List<NganhNgheTD>> getNganhNgheTDs();
}

class NganhNgheTDRepositoryImpl implements NganhNgheTDRepository {
  final NganhNgheTDApiService nganhNgheTDApiService;

  NganhNgheTDRepositoryImpl({required this.nganhNgheTDApiService});

  @override
  Future<List<NganhNgheTD>> getNganhNgheTDs() async {
    final response = await nganhNgheTDApiService.getNganhNgheTD();
    return (response.data['data'] as List)
        .map((json) => NganhNgheTD.fromJson(json))
        .toList();
  }
}
