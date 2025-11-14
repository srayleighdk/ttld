import 'package:ttld/core/services/bac_mon_dao_tao_api_service.dart';
import 'package:ttld/models/bac_mon_dao_tao_model.dart';

abstract class BacMonDaoTaoRepository {
  Future<List<BacMonDaoTao>> getBacMonDaoTaos();
}

class BacMonDaoTaoRepositoryImpl implements BacMonDaoTaoRepository {
  final BacMonDaoTaoApiService apiService;

  BacMonDaoTaoRepositoryImpl({required this.apiService});

  @override
  Future<List<BacMonDaoTao>> getBacMonDaoTaos() async {
    return await apiService.getBacMonDaoTaos();
  }
}
