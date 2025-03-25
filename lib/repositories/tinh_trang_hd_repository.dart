import 'package:ttld/core/services/tinh_trang_hd_api_service.dart';
import 'package:ttld/models/tinh_trang_hd_model.dart';

abstract class TinhTrangHdRepository {
  Future<List<TinhTrangHdModel>> fetchTinhTrangHd();
}

class TinhTrangHdRepositoryImpl implements TinhTrangHdRepository {
  final TinhTrangHdApiService _apiService;

  TinhTrangHdRepositoryImpl(this._apiService);

  @override
  Future<List<TinhTrangHdModel>> fetchTinhTrangHd() async {
    return await _apiService.getTinhTrangHd();
  }
}
