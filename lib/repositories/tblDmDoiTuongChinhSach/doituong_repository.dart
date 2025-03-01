import 'package:ttld/models/doituong_chinhsach/doituong.dart';

abstract class DoiTuongRepository {
  Future<List<DoiTuong>> getDoiTuongs();
  Future<DoiTuong> createDoiTuong(
      DoiTuong doiTuong);
  Future<DoiTuong> updateDoiTuong(
      String id, DoiTuong doiTuong);
  Future<void> deleteDoiTuong(String id);
}
