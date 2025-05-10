import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/nganh_nghe_bachoc.dart';
import 'package:ttld/repositories/nganh_nghe/nganh_nghe_bachoc_repository.dart';

part 'nganh_nghe_bachoc_event.dart';
part 'nganh_nghe_bachoc_state.dart';

class NganhNgheBacHocBloc
    extends Bloc<NganhNgheBacHocEvent, NganhNgheBacHocState> {
  final NganhNgheBacHocRepository nganhNgheBacHocRepository;

  NganhNgheBacHocBloc({required this.nganhNgheBacHocRepository})
      : super(NganhNgheBacHocInitial()) {
    on<LoadNganhNgheBacHocs>(_onLoadNganhNgheBacHocs);
    on<AddNganhNgheBacHoc>(_onAddNganhNgheBacHoc);
    on<UpdateNganhNgheBacHoc>(_onUpdateNganhNgheBacHoc);
    on<DeleteNganhNgheBacHoc>(_onDeleteNganhNgheBacHoc);
  }

  Future<void> _onLoadNganhNgheBacHocs(
      LoadNganhNgheBacHocs event, Emitter<NganhNgheBacHocState> emit) async {
    emit(NganhNgheBacHocLoading());
    try {
      final nganhNgheBacHocs =
          await nganhNgheBacHocRepository.getNganhNgheBacHocs();
      emit(NganhNgheBacHocLoaded(nganhNgheBacHocs: nganhNgheBacHocs));
    } catch (e) {
      emit(NganhNgheBacHocError(message: e.toString()));
    }
  }

  Future<void> _onAddNganhNgheBacHoc(
      AddNganhNgheBacHoc event, Emitter<NganhNgheBacHocState> emit) async {
    try {
      final nganhNgheBacHoc = await nganhNgheBacHocRepository
          .addNganhNgheBacHoc(event.nganhNgheBacHoc);
      if (state is NganhNgheBacHocLoaded) {
        final updatedNganhNgheBacHocs = List<TrinhDoChuyenMon>.from(
            (state as NganhNgheBacHocLoaded).nganhNgheBacHocs)
          ..add(nganhNgheBacHoc);
        emit(NganhNgheBacHocLoaded(nganhNgheBacHocs: updatedNganhNgheBacHocs));
      }
    } catch (e) {
      emit(NganhNgheBacHocError(message: e.toString()));
    }
  }

  Future<void> _onUpdateNganhNgheBacHoc(
      UpdateNganhNgheBacHoc event, Emitter<NganhNgheBacHocState> emit) async {
    try {
      final nganhNgheBacHoc = await nganhNgheBacHocRepository
          .updateNganhNgheBacHoc(event.nganhNgheBacHoc);
      if (state is NganhNgheBacHocLoaded) {
        final updatedNganhNgheBacHocs = (state as NganhNgheBacHocLoaded)
            .nganhNgheBacHocs
            .map((q) => q.id == nganhNgheBacHoc.id ? nganhNgheBacHoc : q)
            .toList();
        emit(NganhNgheBacHocLoaded(nganhNgheBacHocs: updatedNganhNgheBacHocs));
      }
    } catch (e) {
      emit(NganhNgheBacHocError(message: e.toString()));
    }
  }

  Future<void> _onDeleteNganhNgheBacHoc(
      DeleteNganhNgheBacHoc event, Emitter<NganhNgheBacHocState> emit) async {
    try {
      await nganhNgheBacHocRepository.deleteNganhNgheBacHoc(event.id);
      if (state is NganhNgheBacHocLoaded) {
        final updatedNganhNgheBacHocs = (state as NganhNgheBacHocLoaded)
            .nganhNgheBacHocs
            .where((q) => q.id != event.id)
            .toList();
        emit(NganhNgheBacHocLoaded(nganhNgheBacHocs: updatedNganhNgheBacHocs));
      }
    } catch (e) {
      emit(NganhNgheBacHocError(message: e.toString()));
    }
  }
}
