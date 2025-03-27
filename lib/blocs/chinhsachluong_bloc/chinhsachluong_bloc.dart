import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:get_it/get_it.dart';
import '../../models/chinhsachluong/chinhsachluong_model.dart';
import '../../repositories/chinhsachluong_repository.dart';

part 'chinhsachluong_event.dart';
part 'chinhsachluong_state.dart';

class ChinhSachLuongBloc extends Bloc<ChinhSachLuongEvent, ChinhSachLuongState> {
  final ChinhSachLuongRepository _repository;

  ChinhSachLuongBloc() : _repository = GetIt.I<ChinhSachLuongRepository>(), super(ChinhSachLuongInitial()) {
    on<LoadChinhSachLuongs>(_onLoadChinhSachLuongs);
    on<CreateChinhSachLuong>(_onCreateChinhSachLuong);
    on<UpdateChinhSachLuong>(_onUpdateChinhSachLuong);
    on<DeleteChinhSachLuong>(_onDeleteChinhSachLuong);
  }

  Future<void> _onLoadChinhSachLuongs(
    LoadChinhSachLuongs event,
    Emitter<ChinhSachLuongState> emit,
  ) async {
    emit(ChinhSachLuongLoading());
    try {
      final cslList = await _repository.fetchChinhSachLuongs();
      emit(ChinhSachLuongLoadSuccess(cslList));
    } catch (e) {
      emit(ChinhSachLuongOperationFailure(e.toString()));
    }
  }

  Future<void> _onCreateChinhSachLuong(
    CreateChinhSachLuong event,
    Emitter<ChinhSachLuongState> emit,
  ) async {
    emit(ChinhSachLuongLoading());
    try {
      final newCsl = await _repository.createChinhSachLuong(event.csl);
      emit(ChinhSachLuongCreateSuccess(newCsl));
    } catch (e) {
      emit(ChinhSachLuongOperationFailure(e.toString()));
    }
  }

  Future<void> _onUpdateChinhSachLuong(
    UpdateChinhSachLuong event,
    Emitter<ChinhSachLuongState> emit,
  ) async {
    emit(ChinhSachLuongLoading());
    try {
      final updatedCsl = await _repository.updateChinhSachLuong(event.csl);
      emit(ChinhSachLuongUpdateSuccess(updatedCsl));
    } catch (e) {
      emit(ChinhSachLuongOperationFailure(e.toString()));
    }
  }

  Future<void> _onDeleteChinhSachLuong(
    DeleteChinhSachLuong event,
    Emitter<ChinhSachLuongState> emit,
  ) async {
    emit(ChinhSachLuongLoading());
    try {
      await _repository.deleteChinhSachLuong(event.id);
      emit(ChinhSachLuongDeleteSuccess());
    } catch (e) {
      emit(ChinhSachLuongOperationFailure(e.toString()));
    }
  }
}
