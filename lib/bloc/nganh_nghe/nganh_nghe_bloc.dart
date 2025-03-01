import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/nganh_nghe_model.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_repository.dart';

part 'nganh_nghe_event.dart';
part 'nganh_nghe_state.dart';

class NganhNgheBloc extends Bloc<NganhNgheEvent, NganhNgheState> {
  final NganhNgheRepository nganhNgheRepository;

  NganhNgheBloc({required this.nganhNgheRepository}) : super(NganhNgheInitial()) {
    on<LoadNganhNghes>(_onLoadNganhNghes);
    on<AddNganhNghe>(_onAddNganhNghe);
    on<UpdateNganhNghe>(_onUpdateNganhNghe);
    on<DeleteNganhNghe>(_onDeleteNganhNghe);
  }

  Future<void> _onLoadNganhNghes(LoadNganhNghes event, Emitter<NganhNgheState> emit) async {
    emit(NganhNgheLoading());
    try {
      final nganhNghes = await nganhNgheRepository.getNganhNghes();
      emit(NganhNgheLoaded(nganhNghes: nganhNghes));
    } catch (e) {
      emit(NganhNgheError(message: e.toString()));
    }
  }

  Future<void> _onAddNganhNghe(AddNganhNghe event, Emitter<NganhNgheState> emit) async {
    try {
      final nganhNghe = await nganhNgheRepository.addNganhNghe(event.nganhNghe);
      if (state is NganhNgheLoaded) {
        final updatedNganhNghes = List<NganhNghe>.from((state as NganhNgheLoaded).nganhNghes)..add(nganhNghe);
        emit(NganhNgheLoaded(nganhNghes: updatedNganhNghes));
      }
    } catch (e) {
      emit(NganhNgheError(message: e.toString()));
    }
  }

  Future<void> _onUpdateNganhNghe(UpdateNganhNghe event, Emitter<NganhNgheState> emit) async {
    try {
      final nganhNghe = await nganhNgheRepository.updateNganhNghe(event.nganhNghe);
      if (state is NganhNgheLoaded) {
        final updatedNganhNghes = (state as NganhNgheLoaded).nganhNghes.map((q) => q.id == nganhNghe.id ? nganhNghe : q).toList();
        emit(NganhNgheLoaded(nganhNghes: updatedNganhNghes));
      }
    } catch (e) {
      emit(NganhNgheError(message: e.toString()));
    }
  }

  Future<void> _onDeleteNganhNghe(DeleteNganhNghe event, Emitter<NganhNgheState> emit) async {
    try {
      await nganhNgheRepository.deleteNganhNghe(event.id);
      if (state is NganhNgheLoaded) {
        final updatedNganhNghes = (state as NganhNgheLoaded).nganhNghes.where((q) => q.id != event.id).toList();
        emit(NganhNgheLoaded(nganhNghes: updatedNganhNghes));
      }
    } catch (e) {
      emit(NganhNgheError(message: e.toString()));
    }
  }
}
