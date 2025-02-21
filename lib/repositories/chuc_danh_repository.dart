import 'package:ttld/core/services/chuc_danh_api_service.dart';
import 'package:ttld/models/chuc_danh_model.dart';

class ChucDanhRepository {
  final ChucDanhApiService _apiService = ChucDanhApiService();

  Future<List<ChucDanhModel>> getChucDanhs() async {
    return await _apiService.getChucDanhs();
  }
}
