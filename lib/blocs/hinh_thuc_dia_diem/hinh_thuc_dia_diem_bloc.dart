import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/hinh_thuc_dia_diem_model.dart';
import 'package:ttld/repositories/hinh_thuc_dia_diem/hinh_thuc_dia_diem_repository.dart';

part 'hinh_thuc_dia_diem_event.dart';
part 'hinh_thuc_dia_diem_state.dart';

class HinhThucDiaDiemBloc extends Bloc<HinhThucDiaDiemEvent, HinhThucDiaDiemState> {
  final HinhThucDiaDiemRepository hinhThucDiaDiemRepository;

  HinhThucDiaDiemBloc({required this.hinhThucDiaDiemRepository}) : super(HinhThucDiaDiemInitial()) {
    on<LoadHinhThucDiaDiems>(_onLoadHinhThucDiaDiems);
    on<AddHinhThucDiaDiem>(_onAddHinhThucDiaDiem);
    on<UpdateHinhThucDiaDiem>(_onUpdateHinhThucDiaDiem);
    on<DeleteHinhThucDiaDiem>(_onDeleteHinhThucDiaDiem);
  }

  Future<void> _onLoadHinhThucDiaDiems(LoadHinhThucDiaDiems event, Emitter<HinhThucDiaDiemState> emit) async {
    emit(HinhThucDiaDiemLoading());
    try {
      final hinhThucDiaDiems = await hinhThucDiaDiemRepository.getHinhThucDiaDiems();
      emit(HinhThucDiaDiemLoaded(hinhThucDiaDiems: hinhThucDiaDiems));
    } catch (e) {
      emit(HinhThucDiaDiemError(message: e.toString()));
    }
  }

  Future<void> _onAddHinhThucDiaDiem(AddHinhThucDiaDiem event, Emitter<HinhThucDiaDiemState> emit) async {
    try {
      final hinhThucDiaDiem = await hinhThucDiaDiemRepository.addHinhThucDiaDiem(event.hinhThucDiaDiem);
      if (state is HinhThucDiaDiemLoaded) {
        final updatedHinhThucDiaDiems = List<HinhThucDiaDiem>.from((state as HinhThucDiaDiemLoaded).hinhThucDiaDiems)..add(hinhThucDiaDiem);
        emit(HinhThucDiaDiemLoaded(hinhThucDiaDiems: updatedHinhThucDiaDiems));
      }
    } catch (e) {
      emit(HinhThucDiaDiemError(message: e.toString()));
    }
  }

  Future<void> _onUpdateHinhThucDiaDiem(UpdateHinhThucDiaDiem event, Emitter<HinhThucDiaDiemState> emit) async {
    try {
      final hinhThucDiaDiem = await hinhThucDiaDiemRepository.updateHinhThucDiaDiem(event.hinhThucDiaDiem);
      if (state is HinhThucDiaDiemLoaded) {
        final updatedHinhThucDiaDiems = (state as HinhThucDiaDiemLoaded).hinhThucDiaDiems.map((q) => q.id == hinhThucDiaDiem.id ? hinhThucDiaDiem : q).toList();
        emit(HinhThucDiaDiemLoaded(hinhThucDiaDiems: updatedHinhThucDiaDiems));
      }
    } catch (e) {
      emit(HinhThucDiaDiemError(message: e.toString()));
    }
  }

  Future<void> _onDeleteHinhThucDiaDiem(DeleteHinhThucDiaDiem event, Emitter<HinhThucDiaDiemState> emit) async {
    try {
      await hinhThucDiaDiemRepository.deleteHinhThucDiaDiem(event.id.toString());
      if (state is HinhThucDiaDiemLoaded) {
        final updatedHinhThucDiaDiems = (state as HinhThucDiaDiemLoaded).hinhThucDiaDiems.where((q) => q.id != event.id).toList();
        emit(HinhThucDiaDiemLoaded(hinhThucDiaDiems: updatedHinhThucDiaDiems));
      }
    } catch (e) {
      emit(HinhThucDiaDiemError(message: e.toString()));
    }
  }
}
