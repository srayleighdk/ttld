import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ttld/models/hinh_thuc_tuyen_dung_model.dart';
import 'package:ttld/repositories/hinh_thuc_tuyen_dung_repository.dart';

part 'hinh_thuc_tuyen_dung_event.dart';
part 'hinh_thuc_tuyen_dung_state.dart';

@injectable
class HinhThucTuyenDungBloc extends Bloc<HinhThucTuyenDungEvent, HinhThucTuyenDungState> {
  final HinhThucTuyenDungRepository _repository;

  HinhThucTuyenDungBloc(this._repository) : super(HinhThucTuyenDungInitial()) {
    on<LoadHinhThucTuyenDung>(_onLoadHinhThucTuyenDung);
    on<AddHinhThucTuyenDung>(_onAddHinhThucTuyenDung);
    on<UpdateHinhThucTuyenDung>(_onUpdateHinhThucTuyenDung);
    on<DeleteHinhThucTuyenDung>(_onDeleteHinhThucTuyenDung);
  }

  Future<void> _onLoadHinhThucTuyenDung(
    LoadHinhThucTuyenDung event,
    Emitter<HinhThucTuyenDungState> emit,
  ) async {
    emit(HinhThucTuyenDungLoading());
    try {
      final hinhThucs = await _repository.getHinhThucTuyenDung();
      emit(HinhThucTuyenDungLoaded(hinhThucs));
    } catch (e) {
      emit(HinhThucTuyenDungError(e.toString()));
    }
  }

  Future<void> _onAddHinhThucTuyenDung(
    AddHinhThucTuyenDung event,
    Emitter<HinhThucTuyenDungState> emit,
  ) async {
    try {
      await _repository.createHinhThucTuyenDung(event.hinhThuc);
      final updatedList = await _repository.getHinhThucTuyenDung();
      emit(HinhThucTuyenDungLoaded(updatedList));
    } catch (e) {
      emit(HinhThucTuyenDungError(e.toString()));
    }
  }

  Future<void> _onUpdateHinhThucTuyenDung(
    UpdateHinhThucTuyenDung event,
    Emitter<HinhThucTuyenDungState> emit,
  ) async {
    try {
      await _repository.updateHinhThucTuyenDung(event.hinhThuc);
      final updatedList = await _repository.getHinhThucTuyenDung();
      emit(HinhThucTuyenDungLoaded(updatedList));
    } catch (e) {
      emit(HinhThucTuyenDungError(e.toString()));
    }
  }

  Future<void> _onDeleteHinhThucTuyenDung(
    DeleteHinhThucTuyenDung event,
    Emitter<HinhThucTuyenDungState> emit,
  ) async {
    try {
      await _repository.deleteHinhThucTuyenDung(event.id);
      final updatedList = await _repository.getHinhThucTuyenDung();
      emit(HinhThucTuyenDungLoaded(updatedList));
    } catch (e) {
      emit(HinhThucTuyenDungError(e.toString()));
    }
  }
}
