import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ttld/models/tinh_trang_hd_model.dart';
import 'package:ttld/repositories/common_repository.dart';

part 'tinhtrang_hd_state.dart';

class TinhTrangHdCubit extends Cubit<TinhTrangHdState> {
  final CommonRepository _repository;

  TinhTrangHdCubit(this._repository) : super(TinhTrangHdInitial());

  Future<void> fetchTinhTrangHd() async {
    emit(TinhTrangHdLoading());
    try {
      final items = await _repository.fetchTinhTrangHd();
      emit(TinhTrangHdLoaded(items));
    } catch (e) {
      emit(TinhTrangHdError(e.toString()));
    }
  }
}
