import 'package:ttld/core/services/chuc_danh_api_service.dart';
import 'package:ttld/models/chuc_danh_model.dart';

class ChucDanhRepository {
  ChucDanhRepository({required this.chucDanhApiService});
  final ChucDanhApiService chucDanhApiService;

  Future<List<ChucDanhModel>> getChucDanhs() async {
    return await chucDanhApiService.getChucDanhs();
  }
}
