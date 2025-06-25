import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/trinh_do_tin_hoc_model.dart';
import 'package:ttld/repositories/trinh_do_tin_hoc/trinh_do_tin_hoc_repository.dart';

part 'trinh_do_tin_hoc_event.dart';
part 'trinh_do_tin_hoc_state.dart';

class TrinhDoTinHocBloc extends Bloc<TrinhDoTinHocEvent, TrinhDoTinHocState> {
  final TrinhDoTinHocRepository trinhDoTinHocRepository;

  TrinhDoTinHocBloc(this.trinhDoTinHocRepository)
      : super(TrinhDoTinHocInitial()) {
    on<LoadTrinhDoTinHocs>(_onLoadTrinhDoTinHocs);
    on<AddTrinhDoTinHoc>(_onAddTrinhDoTinHoc);
    on<UpdateTrinhDoTinHoc>(_onUpdateTrinhDoTinHoc);
    on<DeleteTrinhDoTinHoc>(_onDeleteTrinhDoTinHoc);
  }

  Future<void> _onLoadTrinhDoTinHocs(
      LoadTrinhDoTinHocs event, Emitter<TrinhDoTinHocState> emit) async {
    emit(TrinhDoTinHocLoading());
    try {
      final trinhDoTinHocs = await trinhDoTinHocRepository.getTrinhDoTinHocs();
      emit(TrinhDoTinHocLoaded(trinhDoTinHocs: trinhDoTinHocs));
    } catch (e) {
      emit(TrinhDoTinHocError(message: e.toString()));
    }
  }

  Future<void> _onAddTrinhDoTinHoc(
      AddTrinhDoTinHoc event, Emitter<TrinhDoTinHocState> emit) async {
    try {
      final trinhDoTinHoc =
          await trinhDoTinHocRepository.addTrinhDoTinHoc(event.trinhDoTinHoc);
      if (state is TrinhDoTinHocLoaded) {
        final updatedTrinhDoTinHocs = List<TrinhDoTinHoc>.from(
            (state as TrinhDoTinHocLoaded).trinhDoTinHocs)
          ..add(trinhDoTinHoc);
        emit(TrinhDoTinHocLoaded(trinhDoTinHocs: updatedTrinhDoTinHocs));
      }
    } catch (e) {
      emit(TrinhDoTinHocError(message: e.toString()));
    }
  }

  Future<void> _onUpdateTrinhDoTinHoc(
      UpdateTrinhDoTinHoc event, Emitter<TrinhDoTinHocState> emit) async {
    try {
      final trinhDoTinHoc = await trinhDoTinHocRepository
          .updateTrinhDoTinHoc(event.trinhDoTinHoc);
      if (state is TrinhDoTinHocLoaded) {
        final updatedTrinhDoTinHocs = (state as TrinhDoTinHocLoaded)
            .trinhDoTinHocs
            .map((q) => q.id == trinhDoTinHoc.id ? trinhDoTinHoc : q)
            .toList();
        emit(TrinhDoTinHocLoaded(trinhDoTinHocs: updatedTrinhDoTinHocs));
      }
    } catch (e) {
      emit(TrinhDoTinHocError(message: e.toString()));
    }
  }

  Future<void> _onDeleteTrinhDoTinHoc(
      DeleteTrinhDoTinHoc event, Emitter<TrinhDoTinHocState> emit) async {
    try {
      await trinhDoTinHocRepository.deleteTrinhDoTinHoc(event.id);
      if (state is TrinhDoTinHocLoaded) {
        final updatedTrinhDoTinHocs = (state as TrinhDoTinHocLoaded)
            .trinhDoTinHocs
            .where((q) => q.id != event.id)
            .toList();
        emit(TrinhDoTinHocLoaded(trinhDoTinHocs: updatedTrinhDoTinHocs));
      }
    } catch (e) {
      emit(TrinhDoTinHocError(message: e.toString()));
    }
  }
}
