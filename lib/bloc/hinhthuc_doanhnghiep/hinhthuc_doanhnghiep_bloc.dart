import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_model.dart';
import 'package:ttld/repositories/hinhthuc_doanhnghiep/hinhthuc_doanhnghiep_repository.dart';

part 'hinhthuc_doanhnghiep_event.dart';
part 'hinhthuc_doanhnghiep_state.dart';

class HinhThucDoanhNghiepBloc extends Bloc<HinhThucDoanhNghiepEvent, HinhThucDoanhNghiepState> {
  final HinhThucDoanhNghiepRepository hinhThucDoanhNghiepRepository;

  HinhThucDoanhNghiepBloc({required this.hinhThucDoanhNghiepRepository}) : super(HinhThucDoanhNghiepInitial()) {
    on<LoadHinhThucDoanhNghieps>(_onLoadHinhThucDoanhNghieps);
    on<AddHinhThucDoanhNghiep>(_onAddHinhThucDoanhNghiep);
    on<UpdateHinhThucDoanhNghiep>(_onUpdateHinhThucDoanhNghiep);
    on<DeleteHinhThucDoanhNghiep>(_onDeleteHinhThucDoanhNghiep);
  }

  Future<void> _onLoadHinhThucDoanhNghieps(LoadHinhThucDoanhNghieps event, Emitter<HinhThucDoanhNghiepState> emit) async {
    emit(HinhThucDoanhNghiepLoading());
    try {
      final hinhThucDoanhNghieps = await hinhThucDoanhNghiepRepository.getHinhThucDoanhNghieps();
      emit(HinhThucDoanhNghiepLoaded(hinhThucDoanhNghieps: hinhThucDoanhNghieps));
    } catch (e) {
      emit(HinhThucDoanhNghiepError(message: e.toString()));
    }
  }

  Future<void> _onAddHinhThucDoanhNghiep(AddHinhThucDoanhNghiep event, Emitter<HinhThucDoanhNghiepState> emit) async {
    try {
      final hinhThucDoanhNghiep = await hinhThucDoanhNghiepRepository.addHinhThucDoanhNghiep(event.hinhThucDoanhNghiep);
      if (state is HinhThucDoanhNghiepLoaded) {
        final updatedHinhThucDoanhNghieps = List<HinhThucDoanhNghiep>.from((state as HinhThucDoanhNghiepLoaded).hinhThucDoanhNghieps)..add(hinhThucDoanhNghiep);
        emit(HinhThucDoanhNghiepLoaded(hinhThucDoanhNghieps: updatedHinhThucDoanhNghieps));
      }
    } catch (e) {
      emit(HinhThucDoanhNghiepError(message: e.toString()));
    }
  }

  Future<void> _onUpdateHinhThucDoanhNghiep(UpdateHinhThucDoanhNghiep event, Emitter<HinhThucDoanhNghiepState> emit) async {
    try {
      final hinhThucDoanhNghiep = await hinhThucDoanhNghiepRepository.updateHinhThucDoanhNghiep(event.hinhThucDoanhNghiep);
      if (state is HinhThucDoanhNghiepLoaded) {
        final updatedHinhThucDoanhNghieps = (state as HinhThucDoanhNghiepLoaded).hinhThucDoanhNghieps.map((q) => q.idLhdn == hinhThucDoanhNghiep.idLhdn ? hinhThucDoanhNghiep : q).toList();
        emit(HinhThucDoanhNghiepLoaded(hinhThucDoanhNghieps: updatedHinhThucDoanhNghieps));
      }
    } catch (e) {
      emit(HinhThucDoanhNghiepError(message: e.toString()));
    }
  }

  Future<void> _onDeleteHinhThucDoanhNghiep(DeleteHinhThucDoanhNghiep event, Emitter<HinhThucDoanhNghiepState> emit) async {
    try {
      await hinhThucDoanhNghiepRepository.deleteHinhThucDoanhNghiep(event.idLhdn);
      if (state is HinhThucDoanhNghiepLoaded) {
        final updatedHinhThucDoanhNghieps = (state as HinhThucDoanhNghiepLoaded).hinhThucDoanhNghieps.where((q) => q.idLhdn != event.idLhdn).toList();
        emit(HinhThucDoanhNghiepLoaded(hinhThucDoanhNghieps: updatedHinhThucDoanhNghieps));
      }
    } catch (e) {
      emit(HinhThucDoanhNghiepError(message: e.toString()));
    }
  }
}
