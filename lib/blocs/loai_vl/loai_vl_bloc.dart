import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/loai_vl_model.dart';
import 'package:ttld/repositories/loai_vl/loai_vl_repository.dart';

part 'loai_vl_event.dart';
part 'loai_vl_state.dart';

class LoaiVLBloc extends Bloc<LoaiVLEvent, LoaiVLState> {
  final LoaiVLRepository loaiVLRepository;

  LoaiVLBloc({required this.loaiVLRepository}) : super(LoaiVLInitial()) {
    on<LoadLoaiVLs>(_onLoadLoaiVLs);
    on<AddLoaiVL>(_onAddLoaiVL);
    on<UpdateLoaiVL>(_onUpdateLoaiVL);
    on<DeleteLoaiVL>(_onDeleteLoaiVL);
  }

  Future<void> _onLoadLoaiVLs(LoadLoaiVLs event, Emitter<LoaiVLState> emit) async {
    emit(LoaiVLLoading());
    try {
      final loaiVLs = await loaiVLRepository.getLoaiVLs();
      emit(LoaiVLLoaded(loaiVLs: loaiVLs));
    } catch (e) {
      emit(LoaiVLError(message: e.toString()));
    }
  }

  Future<void> _onAddLoaiVL(AddLoaiVL event, Emitter<LoaiVLState> emit) async {
    try {
      final loaiVL = await loaiVLRepository.addLoaiVL(event.loaiVL);
      if (state is LoaiVLLoaded) {
        final updatedLoaiVLs = List<LoaiViecLam>.from((state as LoaiVLLoaded).loaiVLs)..add(loaiVL);
        emit(LoaiVLLoaded(loaiVLs: updatedLoaiVLs));
      }
    } catch (e) {
      emit(LoaiVLError(message: e.toString()));
    }
  }

  Future<void> _onUpdateLoaiVL(UpdateLoaiVL event, Emitter<LoaiVLState> emit) async {
    try {
      final loaiVL = await loaiVLRepository.updateLoaiVL(event.loaiVL);
      if (state is LoaiVLLoaded) {
        final updatedLoaiVLs = (state as LoaiVLLoaded).loaiVLs.map((q) => q.loaivieclamTen == loaiVL.loaivieclamTen ? loaiVL : q).toList();
        emit(LoaiVLLoaded(loaiVLs: updatedLoaiVLs));
      }
    } catch (e) {
      emit(LoaiVLError(message: e.toString()));
    }
  }

  Future<void> _onDeleteLoaiVL(DeleteLoaiVL event, Emitter<LoaiVLState> emit) async {
    try {
      await loaiVLRepository.deleteLoaiVL(event.loaivieclamTen);
      if (state is LoaiVLLoaded) {
        final updatedLoaiVLs = (state as LoaiVLLoaded).loaiVLs.where((q) => q.loaivieclamTen != event.loaivieclamTen).toList();
        emit(LoaiVLLoaded(loaiVLs: updatedLoaiVLs));
      }
    } catch (e) {
      emit(LoaiVLError(message: e.toString()));
    }
  }
}
