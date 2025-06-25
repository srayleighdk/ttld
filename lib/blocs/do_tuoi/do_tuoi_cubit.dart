import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:ttld/models/do_tuoi_model.dart';

import '../../../repositories/do_tuoi/do_tuoi_repository.dart';

part 'do_tuoi_state.dart';

@injectable
class DoTuoiCubit extends Cubit<DoTuoiState> {
  final DoTuoiRepository _repository;

  DoTuoiCubit(this._repository) : super(DoTuoiInitial());

  Future<void> getDoTuoi() async {
    emit(DoTuoiLoading());
    try {
      final response = await _repository.getDoTuois();
      emit(DoTuoiLoaded(response));
    } on DioException catch (e) {
      emit(DoTuoiError(e.message ?? 'Có lỗi xảy ra'));
    } catch (e) {
      emit(DoTuoiError('Có lỗi xảy ra'));
    }
  }
}
