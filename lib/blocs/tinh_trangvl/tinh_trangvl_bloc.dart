import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/tinh_trangvl_model.dart';
import 'package:ttld/repositories/tinh_trangvl/tinh_trangvl_repository.dart';

part 'tinh_trangvl_event.dart';
part 'tinh_trangvl_state.dart';

class TinhTrangVLBloc extends Bloc<TinhTrangVLEvent, TinhTrangVLState> {
  final TinhTrangVLRepository tinhTrangVLRepository;

  TinhTrangVLBloc({required this.tinhTrangVLRepository}) : super(TinhTrangVLInitial()) {
    on<LoadTinhTrangVLs>(_onLoadTinhTrangVLs);
    on<AddTinhTrangVL>(_onAddTinhTrangVL);
    on<UpdateTinhTrangVL>(_onUpdateTinhTrangVL);
    on<DeleteTinhTrangVL>(_onDeleteTinhTrangVL);
  }

  Future<void> _onLoadTinhTrangVLs(LoadTinhTrangVLs event, Emitter<TinhTrangVLState> emit) async {
    emit(TinhTrangVLLoading());
    try {
      final tinhTrangVLs = await tinhTrangVLRepository.getTinhTrangVLs();
      emit(TinhTrangVLLoaded(tinhTrangVLs: tinhTrangVLs));
    } catch (e) {
      emit(TinhTrangVLError(message: e.toString()));
    }
  }

  Future<void> _onAddTinhTrangVL(AddTinhTrangVL event, Emitter<TinhTrangVLState> emit) async {
    try {
      final tinhTrangVL = await tinhTrangVLRepository.addTinhTrangVL(event.tinhTrangVL);
      if (state is TinhTrangVLLoaded) {
        final updatedTinhTrangVLs = List<TinhTrangViecLam>.from((state as TinhTrangVLLoaded).tinhTrangVLs)..add(tinhTrangVL);
        emit(TinhTrangVLLoaded(tinhTrangVLs: updatedTinhTrangVLs));
      }
    } catch (e) {
      emit(TinhTrangVLError(message: e.toString()));
    }
  }

  Future<void> _onUpdateTinhTrangVL(UpdateTinhTrangVL event, Emitter<TinhTrangVLState> emit) async {
    try {
      final tinhTrangVL = await tinhTrangVLRepository.updateTinhTrangVL(event.tinhTrangVL);
      if (state is TinhTrangVLLoaded) {
        final updatedTinhTrangVLs = (state as TinhTrangVLLoaded).tinhTrangVLs.map((q) => q.tenTrangThai == tinhTrangVL.tenTrangThai ? tinhTrangVL : q).toList();
        emit(TinhTrangVLLoaded(tinhTrangVLs: updatedTinhTrangVLs));
      }
    } catch (e) {
      emit(TinhTrangVLError(message: e.toString()));
    }
  }

  Future<void> _onDeleteTinhTrangVL(DeleteTinhTrangVL event, Emitter<TinhTrangVLState> emit) async {
    try {
      await tinhTrangVLRepository.deleteTinhTrangVL(event.tenTrangThai);
      if (state is TinhTrangVLLoaded) {
        final updatedTinhTrangVLs = (state as TinhTrangVLLoaded).tinhTrangVLs.where((q) => q.tenTrangThai != event.tenTrangThai).toList();
        emit(TinhTrangVLLoaded(tinhTrangVLs: updatedTinhTrangVLs));
      }
    } catch (e) {
      emit(TinhTrangVLError(message: e.toString()));
    }
  }
}
