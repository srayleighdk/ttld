import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ttld/models/muc_dich_lam_viec_model.dart';
import 'package:ttld/repositories/muc_dich_lam_viec_repository.dart';

part 'muc_dich_lam_viec_event.dart';
part 'muc_dich_lam_viec_state.dart';

@injectable
class MucDichLamViecBloc
    extends Bloc<MucDichLamViecEvent, MucDichLamViecState> {
  final MucDichLamViecRepository _repository;

  MucDichLamViecBloc(this._repository) : super(MucDichLamViecInitial()) {
    on<LoadMucDichLamViec>(_onLoadMucDichLamViec);
    on<AddMucDichLamViec>(_onAddMucDichLamViec);
    on<UpdateMucDichLamViec>(_onUpdateMucDichLamViec);
    on<DeleteMucDichLamViec>(_onDeleteMucDichLamViec);
  }

  Future<void> _onLoadMucDichLamViec(
    LoadMucDichLamViec event,
    Emitter<MucDichLamViecState> emit,
  ) async {
    emit(MucDichLamViecLoading());
    try {
      final mucDichs = await _repository.getMucDichLamViec();
      emit(MucDichLamViecLoaded(mucDichs));
    } catch (e) {
      emit(MucDichLamViecError(e.toString()));
    }
  }

  Future<void> _onAddMucDichLamViec(
    AddMucDichLamViec event,
    Emitter<MucDichLamViecState> emit,
  ) async {
    try {
      await _repository.createMucDichLamViec(event.mucDich);
      final updatedList = await _repository.getMucDichLamViec();
      emit(MucDichLamViecLoaded(updatedList));
    } catch (e) {
      emit(MucDichLamViecError(e.toString()));
    }
  }

  Future<void> _onUpdateMucDichLamViec(
    UpdateMucDichLamViec event,
    Emitter<MucDichLamViecState> emit,
  ) async {
    try {
      await _repository.updateMucDichLamViec(event.mucDich);
      final updatedList = await _repository.getMucDichLamViec();
      emit(MucDichLamViecLoaded(updatedList));
    } catch (e) {
      emit(MucDichLamViecError(e.toString()));
    }
  }

  Future<void> _onDeleteMucDichLamViec(
    DeleteMucDichLamViec event,
    Emitter<MucDichLamViecState> emit,
  ) async {
    try {
      await _repository.deleteMucDichLamViec(event.id);
      final updatedList = await _repository.getMucDichLamViec();
      emit(MucDichLamViecLoaded(updatedList));
    } catch (e) {
      emit(MucDichLamViecError(e.toString()));
    }
  }
}
