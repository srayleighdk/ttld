import 'package:ttld/core/services/doituongchinhsach_api_service.dart';
import 'package:ttld/models/doituong_chinhsach/doituong.dart';
import 'package:ttld/repositories/tblDmDoiTuongChinhSach/doituong_repository.dart';

class DoiTuongChinhSachRepositoryImpl implements DoiTuongChinhSachRepository {
  final DoiTuongChinhSachApiService doiTuongChinhSachApiService;

  DoiTuongChinhSachRepositoryImpl(
      this.doiTuongChinhSachApiService); // Inject the API service

  @override
  Future<List<DoiTuongChinhSach>> getDoiTuongChinhSachs() async {
    return await doiTuongChinhSachApiService.getDoiTuongChinhSachs();
  }

  @override
  Future<DoiTuongChinhSach> createDoiTuongChinhSach(
      DoiTuongChinhSach doiTuongChinhSach) async {
    return await doiTuongChinhSachApiService
        .createDoiTuongChinhSach(doiTuongChinhSach);
  }

  @override
  Future<DoiTuongChinhSach> updateDoiTuongChinhSach(
      int id, DoiTuongChinhSach doiTuongChinhSach) async {
    return await doiTuongChinhSachApiService.updateDoiTuongChinhSach(
        id, doiTuongChinhSach);
  }

  @override
  Future<void> deleteDoiTuongChinhSach(int id) async {
    await doiTuongChinhSachApiService.deleteDoiTuongChinhSach(id);
  }
}
