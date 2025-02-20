import 'package:ttld/core/services/don_vi_api_service.dart';
import 'package:ttld/models/don_vi_model.dart';

abstract class DonViRepository {
  Future<List<DonVi>> getDonVis();
  Future<DonVi> addDonVi(DonVi donVi);
  Future<DonVi> updateDonVi(DonVi donVi);
  Future<void> deleteDonVi(String id);
}

class DonViRepositoryImpl implements DonViRepository {
  final DonViApiService donViApiService;

  DonViRepositoryImpl({required this.donViApiService});

  @override
  Future<List<DonVi>> getDonVis() async {
    final response = await donViApiService.getDonVi();
    return (response.data['data'] as List)
        .map((json) => DonVi.fromJson(json))
        .toList();
  }

  @override
  Future<DonVi> addDonVi(DonVi donVi) async {
    final response = await donViApiService.postDonVi(donVi.toJson());
    return DonVi.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<DonVi> updateDonVi(DonVi donVi) async {
    final response = await donViApiService.putDonVi(donVi.toJson());
    return DonVi.fromJson(response.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<void> deleteDonVi(String id) async {
    await donViApiService.deleteDonVi(id);
  }
}
