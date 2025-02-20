import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/loai_hinh_model.dart';
import 'package:ttld/repositories/loai_hinh/loai_hinh_repository.dart';

part 'loai_hinh_event.dart';
part 'loai_hinh_state.dart';

class LoaiHinhBloc extends Bloc<LoaiHinhEvent, LoaiHinhState> {
  final LoaiHinhRepository loaiHinhRepository;

  LoaiHinhBloc({required this.loaiHinhRepository}) : super(LoaiHinhInitial()) {
    on<LoadLoaiHinhs>(_onLoadLoaiHinhs);
    on<AddLoaiHinh>(_onAddLoaiHinh);
    on<UpdateLoaiHinh>(_onUpdateLoaiHinh);
    on<DeleteLoaiHinh>(_onDeleteLoaiHinh);
  }

  Future<void> _onLoadLoaiHinhs(LoadLoaiHinhs event, Emitter<LoaiHinhState> emit) async {
    emit(LoaiHinhLoading());
    try {
      final loaiHinhs = await loaiHinhRepository.getLoaiHinhs();
      emit(LoaiHinhLoaded(loaiHinhs: loaiHinhs));
    } catch (e) {
      emit(LoaiHinhError(message: e.toString()));
    }
  }

  Future<void> _onAddLoaiHinh(AddLoaiHinh event, Emitter<LoaiHinhState> emit) async {
    try {
      final loaiHinh = await loaiHinhRepository.addLoaiHinh(event.loaiHinh);
      if (state is LoaiHinhLoaded) {
        final updatedLoaiHinhs = List<LoaiHinh>.from((state as LoaiHinhLoaded).loaiHinhs)..add(loaiHinh);
        emit(LoaiHinhLoaded(loaiHinhs: updatedLoaiHinhs));
      }
    } catch (e) {
      emit(LoaiHinhError(message: e.toString()));
    }
  }

  Future<void> _onUpdateLoaiHinh(UpdateLoaiHinh event, Emitter<LoaiHinhState> emit) async {
    try {
      final loaiHinh = await loaiHinhRepository.updateLoaiHinh(event.loaiHinh);
      if (state is LoaiHinhLoaded) {
        final updatedLoaiHinhs = (state as LoaiHinhLoaded).loaiHinhs.map((q) => q.idLhdn == loaiHinh.idLhdn ? loaiHinh : q).toList();
        emit(LoaiHinhLoaded(loaiHinhs: updatedLoaiHinhs));
      }
    } catch (e) {
      emit(LoaiHinhError(message: e.toString()));
    }
  }

  Future<void> _onDeleteLoaiHinh(DeleteLoaiHinh event, Emitter<LoaiHinhState> emit) async {
    try {
      await loaiHinhRepository.deleteLoaiHinh(event.idLhdn);
      if (state is LoaiHinhLoaded) {
        final updatedLoaiHinhs = (state as LoaiHinhLoaded).loaiHinhs.where((q) => q.idLhdn != event.idLhdn).toList();
        emit(LoaiHinhLoaded(loaiHinhs: updatedLoaiHinhs));
      }
    } catch (e) {
      emit(LoaiHinhError(message: e.toString()));
    }
  }
}
