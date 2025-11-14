import 'package:ttld/core/services/chuyen_nganh_dao_tao_api_service.dart';
import 'package:ttld/models/chuyen_nganh_dao_tao_model.dart';

abstract class ChuyenNganhDaoTaoRepository {
  Future<List<ChuyenNganhDaoTao>> getChuyenNganhDaoTaos();
}

class ChuyenNganhDaoTaoRepositoryImpl implements ChuyenNganhDaoTaoRepository {
  final ChuyenNganhDaoTaoApiService apiService;

  ChuyenNganhDaoTaoRepositoryImpl({required this.apiService});

  @override
  Future<List<ChuyenNganhDaoTao>> getChuyenNganhDaoTaos() async {
    return await apiService.getChuyenNganhDaoTaos();
  }
}
