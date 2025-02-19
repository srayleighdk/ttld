import 'package:ttld/models/chuyenmon/chuyenmon.dart';

abstract class ChuyenMonRepository {
  Future<List<ChuyenMon>> getChuyenMons();
  Future<ChuyenMon> createChuyenMon(ChuyenMon chuyenMon);
  Future<ChuyenMon> updateChuyenMon(int id, ChuyenMon chuyenMon);
  Future<void> deleteChuyenMon(int id);
}
