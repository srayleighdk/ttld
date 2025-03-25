import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ttld/models/tinh_trang_hd_model.dart';
import 'package:ttld/repositories/tinh_trang_hd_repository.dart';

part 'tinhtrang_hd_state.dart';

class TinhTrangHdCubit extends Cubit<TinhTrangHdState> {
  final TinhTrangHdRepository _repository;

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
