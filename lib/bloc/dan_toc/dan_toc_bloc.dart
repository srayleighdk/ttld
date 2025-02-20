import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/dan_toc_model.dart';
import 'package:ttld/repositories/dan_toc/dan_toc_repository.dart';

part 'dan_toc_event.dart';
part 'dan_toc_state.dart';

class DanTocBloc extends Bloc<DanTocEvent, DanTocState> {
  final DanTocRepository danTocRepository;

  DanTocBloc({required this.danTocRepository}) : super(DanTocInitial()) {
    on<LoadDanTocs>(_onLoadDanTocs);
    on<AddDanToc>(_onAddDanToc);
    on<UpdateDanToc>(_onUpdateDanToc);
    on<DeleteDanToc>(_onDeleteDanToc);
  }

  Future<void> _onLoadDanTocs(LoadDanTocs event, Emitter<DanTocState> emit) async {
    emit(DanTocLoading());
    try {
      final danTocs = await danTocRepository.getDanTocs();
      emit(DanTocLoaded(danTocs: danTocs));
    } catch (e) {
      emit(DanTocError(message: e.toString()));
    }
  }

  Future<void> _onAddDanToc(AddDanToc event, Emitter<DanTocState> emit) async {
    try {
      final danToc = await danTocRepository.addDanToc(event.danToc);
      if (state is DanTocLoaded) {
        final updatedDanTocs = List<DanToc>.from((state as DanTocLoaded).danTocs)..add(danToc);
        emit(DanTocLoaded(danTocs: updatedDanTocs));
      }
    } catch (e) {
      emit(DanTocError(message: e.toString()));
    }
  }

  Future<void> _onUpdateDanToc(UpdateDanToc event, Emitter<DanTocState> emit) async {
    try {
      final danToc = await danTocRepository.updateDanToc(event.danToc);
      if (state is DanTocLoaded) {
        final updatedDanTocs = (state as DanTocLoaded).danTocs.map((q) => q.tenDt == danToc.tenDt ? danToc : q).toList();
        emit(DanTocLoaded(danTocs: updatedDanTocs));
      }
    } catch (e) {
      emit(DanTocError(message: e.toString()));
    }
  }

  Future<void> _onDeleteDanToc(DeleteDanToc event, Emitter<DanTocState> emit) async {
    try {
      await danTocRepository.deleteDanToc(event.tenDt);
      if (state is DanTocLoaded) {
        final updatedDanTocs = (state as DanTocLoaded).danTocs.where((q) => q.tenDt != event.tenDt).toList();
        emit(DanTocLoaded(danTocs: updatedDanTocs));
      }
    } catch (e) {
      emit(DanTocError(message: e.toString()));
    }
  }
}
