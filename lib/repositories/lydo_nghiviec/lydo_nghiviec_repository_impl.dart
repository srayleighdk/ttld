import 'package:ttld/core/services/lydo_nghiviec_api_service.dart';
import 'package:ttld/models/lydo_nghiviec/lydo_nghiviec_model.dart';
import 'package:ttld/repositories/lydo_nghiviec/lydo_nghiviec_repository.dart';

class LydoNghiviecRepositoryImpl implements LydoNghiviecRepository {
  final LydoNghiviecApiService apiService;

  LydoNghiviecRepositoryImpl(this.apiService);

  @override
  Future<List<LydoNghiviec>> getLydoNghiviecs() async {
    return await apiService.getLydoNghiviecs();
  }
}
