import 'package:ttld/models/tttantat/tttantat.dart';

abstract class TinhTrangTanTatRepository {
  Future<List<TinhTrangTanTat>> getTinhTrangTanTats();
  Future<TinhTrangTanTat> createTinhTrangTanTat(
      TinhTrangTanTat tinhTrangTanTat);
  Future<TinhTrangTanTat> updateTinhTrangTanTat(
      int id, TinhTrangTanTat tinhTrangTanTat);
  Future<void> deleteTinhTrangTanTat(int id);
}
