import 'package:ttld/core/services/ve_tinh_api_service.dart';
import 'package:ttld/models/ve_tinh_model.dart';

abstract class VeTinhRepository {
  Future<List<VeTinh>> getVeTinhs();
}

class VeTinhRepositoryImpl implements VeTinhRepository {
  final VeTinhApiService apiService;

  VeTinhRepositoryImpl({required this.apiService});

  @override
  Future<List<VeTinh>> getVeTinhs() async {
    final response = await apiService.getAll();
    return (response.data['data'] as List)
        .map((json) => VeTinh.fromJson(json))
        .toList();
  }
}
