import 'package:ttld/core/services/chuc_danh_api_service.dart';
import 'package:ttld/models/chuc_danh_model.dart';

abstract class ChucDanhRepository {
  Future<List<ChucDanhModel>> getChucDanhs();
}

class ChucDanhRepositoryImpl implements ChucDanhRepository {
  ChucDanhRepositoryImpl({required this.chucDanhApiService});
  final ChucDanhApiService chucDanhApiService;

  @override
  Future<List<ChucDanhModel>> getChucDanhs() async {
    return await chucDanhApiService.getChucDanhs();
  }
}
