import 'package:ttld/models/doituong_chinhsach/doituong.dart';

abstract class DoiTuongChinhSachRepository {
  Future<List<DoiTuongChinhSach>> getDoiTuongChinhSachs();
  Future<DoiTuongChinhSach> createDoiTuongChinhSach(
      DoiTuongChinhSach doiTuongChinhSach);
  Future<DoiTuongChinhSach> updateDoiTuongChinhSach(
      int id, DoiTuongChinhSach doiTuongChinhSach);
  Future<void> deleteDoiTuongChinhSach(int id);
}
