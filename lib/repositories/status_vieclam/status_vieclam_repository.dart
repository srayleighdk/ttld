import 'package:ttld/core/services/status_vieclam_api_service.dart';
import 'package:ttld/models/status_vieclam_model.dart';

abstract class StatusViecLamRepository {
  Future<List<StatusViecLam>> getStatusViecLams();
}

class StatusViecLamRepositoryImpl implements StatusViecLamRepository {
  final StatusViecLamApiService apiService;

  StatusViecLamRepositoryImpl({required this.apiService});

  @override
  Future<List<StatusViecLam>> getStatusViecLams() async {
    return await apiService.getStatusViecLams();
  }
}
