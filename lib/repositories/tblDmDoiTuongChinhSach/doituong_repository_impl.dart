import 'package:ttld/core/services/doituongchinhsach_api_service.dart';
import 'package:ttld/models/doituong_chinhsach/doituong.dart';
import 'package:ttld/repositories/tblDmDoiTuongChinhSach/doituong_repository.dart';

class DoiTuongRepositoryImpl implements DoiTuongRepository {
  final DoiTuongApiService doiTuongApiService;

  DoiTuongRepositoryImpl(this.doiTuongApiService); // Inject the API service

  @override
  Future<List<DoiTuong>> getDoiTuongs() async {
    final response = await doiTuongApiService.getDoiTuongs();
    return (response.data['data'] as List)
        .map((json) => DoiTuong.fromJson(json))
        .toList();
  }

  @override
  Future<DoiTuong> createDoiTuong(DoiTuong doiTuong) async {
    final response = await doiTuongApiService.postDoiTuong(doiTuong.toJson());
    return DoiTuong.fromJson(response.data);
  }

  @override
  Future<DoiTuong> updateDoiTuong(String id, DoiTuong doiTuong) async {
    final response = await doiTuongApiService.putDoiTuong(doiTuong.toJson());
    return DoiTuong.fromJson(response.data);
  }

  @override
  Future<void> deleteDoiTuong(String id) async {
    await doiTuongApiService.deleteDoiTuong(id);
  }
}
