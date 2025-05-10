import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/kieuchapnoi_model.dart';
import 'package:ttld/repositories/kieuchapnoi_repository.dart';

class KieuChapNoiCubit extends Cubit<List<KieuChapNoiModel>> {
  final KieuChapNoiRepository _repository;

  KieuChapNoiCubit(this._repository) : super([]);

  Future<void> loadKieuChapNois() async {
    try {
      final kieuChapNois = await _repository.getKieuChapNois();
      emit(kieuChapNois);
    } catch (e) {
      emit([]);
    }
  }
} 