import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ttld/models/kinh_nghiem_lam_viec.dart';
import 'package:ttld/repositories/kinh_nghiem_lam_viec_repository.dart';

part 'kinh_nghiem_lam_viec_event.dart';
part 'kinh_nghiem_lam_viec_state.dart';

@injectable
class KinhNghiemLamViecBloc
    extends Bloc<KinhNghiemLamViecEvent, KinhNghiemLamViecState> {
  final KinhNghiemLamViecRepository _repository;

  KinhNghiemLamViecBloc(this._repository) : super(KinhNghiemLamViecInitial()) {
    on<LoadKinhNghiem>(_onLoadKinhNghiem);
    on<AddKinhNghiem>(_onAddKinhNghiem);
    on<UpdateKinhNghiem>(_onUpdateKinhNghiem);
    on<DeleteKinhNghiem>(_onDeleteKinhNghiem);
  }

  Future<void> _onLoadKinhNghiem(
    LoadKinhNghiem event,
    Emitter<KinhNghiemLamViecState> emit,
  ) async {
    emit(KinhNghiemLamViecLoading());
    try {
      final kinhNghiem = await _repository.getKinhNghiemLamViecs();
      emit(KinhNghiemLamViecLoaded(kinhNghiem));
    } catch (e) {
      emit(KinhNghiemLamViecError(e.toString()));
    }
  }

  Future<void> _onAddKinhNghiem(
    AddKinhNghiem event,
    Emitter<KinhNghiemLamViecState> emit,
  ) async {
    try {
      await _repository.createKinhNghiem(event.kinhNghiem);
      final updatedList = await _repository.getKinhNghiemLamViecs();
      emit(KinhNghiemLamViecLoaded(updatedList));
    } catch (e) {
      emit(KinhNghiemLamViecError(e.toString()));
    }
  }

  Future<void> _onUpdateKinhNghiem(
    UpdateKinhNghiem event,
    Emitter<KinhNghiemLamViecState> emit,
  ) async {
    try {
      await _repository.updateKinhNghiem(event.kinhNghiem);
      final updatedList = await _repository.getKinhNghiemLamViecs();
      emit(KinhNghiemLamViecLoaded(updatedList));
    } catch (e) {
      emit(KinhNghiemLamViecError(e.toString()));
    }
  }

  Future<void> _onDeleteKinhNghiem(
    DeleteKinhNghiem event,
    Emitter<KinhNghiemLamViecState> emit,
  ) async {
    try {
      await _repository.deleteKinhNghiem(event.id);
      // final updatedList = await _repository.deleteKinhNghiem(event.id);
      emit(KinhNghiemLamViecDeleted());
    } catch (e) {
      emit(KinhNghiemLamViecError(e.toString()));
    }
  }
}
