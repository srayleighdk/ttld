import 'package:ttld/models/lydo_nghiviec/lydo_nghiviec_model.dart';

abstract class LydoNghiviecRepository {
  Future<List<LydoNghiviec>> getLydoNghiviecs();
}
