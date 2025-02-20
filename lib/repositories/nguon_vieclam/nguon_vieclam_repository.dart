import 'package:ttld/core/services/nguon_vieclam_api_service.dart';
import 'package:ttld/models/nguon_vieclam_model.dart';

abstract class NguonViecLamRepository {
  Future<List<NguonViecLam>> getNguonViecLams();
  Future<NguonViecLam> addNguonViecLam(NguonViecLam nguonViecLam);
  Future<NguonViecLam> updateNguonViecLam(NguonViecLam nguonViecLam);
  Future<void> deleteNguonViecLam(String id);
}

class NguonViecLamRepositoryImpl implements NguonViecLamRepository {
  final NguonViecLamApiService nguonViecLamApiService;

  NguonViecLamRepositoryImpl({required this.nguonViecLamApiService});

  @override
  Future<List<NguonViecLam>> getNguonViecLams() async {
    final response = await nguonViecLamApiService.getNguonViecLam();
    return (response.data['data'] as List)
        .map((json) => NguonViecLam.fromJson(json))
        .toList();
  }

  @override
  Future<NguonViecLam> addNguonViecLam(NguonViecLam nguonViecLam) async {
    final response = await nguonViecLamApiService.postNguonViecLam(nguonViecLam.toJson());
    return NguonViecLam.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<NguonViecLam> updateNguonViecLam(NguonViecLam nguonViecLam) async {
    final response = await nguonViecLamApiService.putNguonViecLam(nguonViecLam.toJson());
    return NguonViecLam.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteNguonViecLam(String id) async {
    await nguonViecLamApiService.deleteNguonViecLam(id);
  }
}
