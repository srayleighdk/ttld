import 'package:ttld/core/services/m01tt11_api_service.dart';
import 'package:ttld/models/m01tt11_model.dart';
import 'package:ttld/repositories/m01tt11/m01tt11_repository.dart';

class M01TT11RepositoryImpl implements M01TT11Repository {
  final M01TT11ApiService apiService;

  M01TT11RepositoryImpl({required this.apiService});

  @override
  Future<List<M01TT11>> getAllM01TT11() async {
    return await apiService.getAllM01TT11();
  }

  @override
  Future<M01TT11> createM01TT11(M01TT11 m01tt11) async {
    return await apiService.createM01TT11(m01tt11);
  }

  @override
  Future<M01TT11> updateM01TT11(String id, M01TT11 m01tt11) async {
    return await apiService.updateM01TT11(id, m01tt11);
  }

  @override
  Future<void> deleteM01TT11(String id) async {
    await apiService.deleteM01TT11(id);
  }
}
