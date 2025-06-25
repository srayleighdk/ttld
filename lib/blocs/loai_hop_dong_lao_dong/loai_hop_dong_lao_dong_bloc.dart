import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ttld/models/loai_hop_dong_lao_dong_model.dart';
import 'package:ttld/repositories/loai_hop_dong_lao_dong_repository.dart';

part 'loai_hop_dong_lao_dong_event.dart';
part 'loai_hop_dong_lao_dong_state.dart';

@injectable
class LoaiHopDongLaoDongBloc extends Bloc<LoaiHopDongLaoDongEvent, LoaiHopDongLaoDongState> {
  final LoaiHopDongLaoDongRepository _repository;

  LoaiHopDongLaoDongBloc(this._repository) : super(LoaiHopDongLaoDongInitial()) {
    on<LoadLoaiHopDong>(_onLoadLoaiHopDong);
    on<AddLoaiHopDong>(_onAddLoaiHopDong);
    on<UpdateLoaiHopDong>(_onUpdateLoaiHopDong);
    on<DeleteLoaiHopDong>(_onDeleteLoaiHopDong);
  }

  Future<void> _onLoadLoaiHopDong(
    LoadLoaiHopDong event,
    Emitter<LoaiHopDongLaoDongState> emit,
  ) async {
    emit(LoaiHopDongLaoDongLoading());
    try {
      final loaiHopDongs = await _repository.getLoaiHopDong();
      emit(LoaiHopDongLaoDongLoaded(loaiHopDongs));
    } catch (e) {
      emit(LoaiHopDongLaoDongError(e.toString()));
    }
  }

  Future<void> _onAddLoaiHopDong(
    AddLoaiHopDong event,
    Emitter<LoaiHopDongLaoDongState> emit,
  ) async {
    try {
      await _repository.createLoaiHopDong(event.loaiHopDong);
      final updatedList = await _repository.getLoaiHopDong();
      emit(LoaiHopDongLaoDongLoaded(updatedList));
    } catch (e) {
      emit(LoaiHopDongLaoDongError(e.toString()));
    }
  }

  Future<void> _onUpdateLoaiHopDong(
    UpdateLoaiHopDong event,
    Emitter<LoaiHopDongLaoDongState> emit,
  ) async {
    try {
      await _repository.updateLoaiHopDong(event.loaiHopDong);
      final updatedList = await _repository.getLoaiHopDong();
      emit(LoaiHopDongLaoDongLoaded(updatedList));
    } catch (e) {
      emit(LoaiHopDongLaoDongError(e.toString()));
    }
  }

  Future<void> _onDeleteLoaiHopDong(
    DeleteLoaiHopDong event,
    Emitter<LoaiHopDongLaoDongState> emit,
  ) async {
    try {
      await _repository.deleteLoaiHopDong(event.id);
      final updatedList = await _repository.getLoaiHopDong();
      emit(LoaiHopDongLaoDongLoaded(updatedList));
    } catch (e) {
      emit(LoaiHopDongLaoDongError(e.toString()));
    }
  }
}
