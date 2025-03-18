import 'package:ttld/models/tinh_trang_hd_model.dart';

abstract class CommonRepository {
  Future<List<TinhTrangHdModel>> fetchTinhTrangHd();
}
