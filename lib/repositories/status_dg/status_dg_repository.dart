import 'package:ttld/core/services/status_dg_api_service.dart';
import 'package:ttld/models/status_dg_model.dart';

abstract class StatusDgRepository {
  Future<List<StatusDg>> getStatusDgs();
}

class StatusDgRepositoryImpl implements StatusDgRepository {
  final StatusDgApiService apiService;

  StatusDgRepositoryImpl({required this.apiService});

  @override
  Future<List<StatusDg>> getStatusDgs() async {
    return await apiService.getStatusDgs();
  }
}
