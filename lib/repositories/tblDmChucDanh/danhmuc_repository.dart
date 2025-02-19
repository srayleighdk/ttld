import 'package:ttld/models/danhmuc/danhmuc.dart';

abstract class DanhMucRepository {
  Future<List<DanhMuc>> getDanhMucs();
  Future<DanhMuc> createDanhMuc(DanhMuc danhmuc);
  Future<DanhMuc> updateDanhMuc(int id, DanhMuc danhmuc);
  Future<void> deleteDanhMuc(int id);
}
