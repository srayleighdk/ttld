import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/bloc/huyen/huyen_event.dart';
import 'package:ttld/bloc/huyen/huyen_state.dart';
import 'package:ttld/models/huyen/huyen.dart';
import 'package:ttld/repositories/huyen/huyen_repository.dart';

class HuyenBloc extends Bloc<HuyenEvent, HuyenState> {
  final HuyenRepository huyenRepository;

  HuyenBloc({required this.huyenRepository}) : super(HuyenInitial()) {
    on<LoadHuyens>(_onLoadHuyens);
    on<AddHuyen>(_onAddHuyen);
    on<UpdateHuyen>(_onUpdateHuyen);
    on<DeleteHuyen>(_onDeleteHuyen);
  }

  Future<void> _onLoadHuyens(LoadHuyens event, Emitter<HuyenState> emit) async {
    emit(HuyenLoading());
    try {
      final huyens = await huyenRepository.getHuyens();
      emit(HuyenLoaded(huyens: huyens));
    } catch (e) {
      emit(HuyenError(message: e.toString()));
    }
  }

  Future<void> _onAddHuyen(AddHuyen event, Emitter<HuyenState> emit) async {
    try {
      final huyen = await huyenRepository.addHuyen(event.huyen);
      if (state is HuyenLoaded) {
        final List<Huyen> updatedHuyens = List.from((state as HuyenLoaded).huyens)..add(huyen);
        emit(HuyenLoaded(huyens: updatedHuyens));
      }
    } catch (e) {
      emit(HuyenError(message: e.toString()));
    }
  }

  Future<void> _onUpdateHuyen(UpdateHuyen event, Emitter<HuyenState> emit) async {
    try {
      final huyen = await huyenRepository.updateHuyen(event.huyen);
      if (state is HuyenLoaded) {
        final List<Huyen> updatedHuyens = (state as HuyenLoaded).huyens.map((existingHuyen) {
          return existingHuyen.mahuyen == huyen.mahuyen ? huyen : existingHuyen;
        }).toList();
        emit(HuyenLoaded(huyens: updatedHuyens));
      }
    } catch (e) {
      emit(HuyenError(message: e.toString()));
    }
  }

  Future<void> _onDeleteHuyen(DeleteHuyen event, Emitter<HuyenState> emit) async {
    try {
      await huyenRepository.deleteHuyen(event.id);
      if (state is HuyenLoaded) {
        final List<Huyen> updatedHuyens = (state as HuyenLoaded).huyens.where((huyen) => huyen.mahuyen != event.id).toList();
        emit(HuyenLoaded(huyens: updatedHuyens));
      }
    } catch (e) {
      emit(HuyenError(message: e.toString()));
    }
  }
}
