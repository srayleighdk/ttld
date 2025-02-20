import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/nganh_nghe_capdo.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_capdo_repository.dart';

part 'nganh_nghe_capdo_event.dart';
part 'nganh_nghe_capdo_state.dart';

class NganhNgheCapDoBloc extends Bloc<NganhNgheCapDoEvent, NganhNgheCapDoState> {
  final NganhNgheCapDoRepository nganhNgheCapDoRepository;

  NganhNgheCapDoBloc({required this.nganhNgheCapDoRepository}) : super(NganhNgheCapDoInitial()) {
    on<LoadNganhNgheCapDos>(_onLoadNganhNgheCapDos);
    on<AddNganhNgheCapDo>(_onAddNganhNgheCapDo);
    on<UpdateNganhNgheCapDo>(_onUpdateNganhNgheCapDo);
    on<DeleteNganhNgheCapDo>(_onDeleteNganhNgheCapDo);
  }

  Future<void> _onLoadNganhNgheCapDos(LoadNganhNgheCapDos event, Emitter<NganhNgheCapDoState> emit) async {
    emit(NganhNgheCapDoLoading());
    try {
      final nganhNgheCapDos = await nganhNgheCapDoRepository.getNganhNgheCapDos();
      emit(NganhNgheCapDoLoaded(nganhNgheCapDos: nganhNgheCapDos));
    } catch (e) {
      emit(NganhNgheCapDoError(message: e.toString()));
    }
  }

  Future<void> _onAddNganhNgheCapDo(AddNganhNgheCapDo event, Emitter<NganhNgheCapDoState> emit) async {
    try {
      final nganhNgheCapDo = await nganhNgheCapDoRepository.addNganhNgheCapDo(event.nganhNgheCapDo);
      if (state is NganhNgheCapDoLoaded) {
        final updatedNganhNgheCapDos = List<NganhNgheCapDo>.from((state as NganhNgheCapDoLoaded).nganhNgheCapDos)..add(nganhNgheCapDo);
        emit(NganhNgheCapDoLoaded(nganhNgheCapDos: updatedNganhNgheCapDos));
      }
    } catch (e) {
      emit(NganhNgheCapDoError(message: e.toString()));
    }
  }

  Future<void> _onUpdateNganhNgheCapDo(UpdateNganhNgheCapDo event, Emitter<NganhNgheCapDoState> emit) async {
    try {
      final nganhNgheCapDo = await nganhNgheCapDoRepository.updateNganhNgheCapDo(event.nganhNgheCapDo);
      if (state is NganhNgheCapDoLoaded) {
        final updatedNganhNgheCapDos = (state as NganhNgheCapDoLoaded).nganhNgheCapDos.map((q) => q.groupId == nganhNgheCapDo.groupId ? nganhNgheCapDo : q).toList();
        emit(NganhNgheCapDoLoaded(nganhNgheCapDos: updatedNganhNgheCapDos));
      }
    } catch (e) {
      emit(NganhNgheCapDoError(message: e.toString()));
    }
  }

  Future<void> _onDeleteNganhNgheCapDo(DeleteNganhNgheCapDo event, Emitter<NganhNgheCapDoState> emit) async {
    try {
      await nganhNgheCapDoRepository.deleteNganhNgheCapDo(event.groupId.toString());
      if (state is NganhNgheCapDoLoaded) {
        final updatedNganhNgheCapDos = (state as NganhNgheCapDoLoaded).nganhNgheCapDos.where((q) => q.groupId != event.groupId).toList();
        emit(NganhNgheCapDoLoaded(nganhNgheCapDos: updatedNganhNgheCapDos));
      }
    } catch (e) {
      emit(NganhNgheCapDoError(message: e.toString()));
    }
  }
}
