import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/hinh_thuc_loai_hinh_model.dart';
import 'package:ttld/repositories/hinh_thuc_loai_hinh/hinh_thuc_loai_hinh_repository.dart';

part 'hinh_thuc_loai_hinh_event.dart';
part 'hinh_thuc_loai_hinh_state.dart';

class HinhThucLoaiHinhBloc extends Bloc<HinhThucLoaiHinhEvent, HinhThucLoaiHinhState> {
  final HinhThucLoaiHinhRepository hinhThucLoaiHinhRepository;

  HinhThucLoaiHinhBloc({required this.hinhThucLoaiHinhRepository}) : super(HinhThucLoaiHinhInitial()) {
    on<LoadHinhThucLoaiHinhs>(_onLoadHinhThucLoaiHinhs);
    on<AddHinhThucLoaiHinh>(_onAddHinhThucLoaiHinh);
    on<UpdateHinhThucLoaiHinh>(_onUpdateHinhThucLoaiHinh);
    on<DeleteHinhThucLoaiHinh>(_onDeleteHinhThucLoaiHinh);
  }

  Future<void> _onLoadHinhThucLoaiHinhs(LoadHinhThucLoaiHinhs event, Emitter<HinhThucLoaiHinhState> emit) async {
    emit(HinhThucLoaiHinhLoading());
    try {
      final hinhThucLoaiHinhs = await hinhThucLoaiHinhRepository.getHinhThucLoaiHinhs();
      emit(HinhThucLoaiHinhLoaded(hinhThucLoaiHinhs: hinhThucLoaiHinhs));
    } catch (e) {
      emit(HinhThucLoaiHinhError(message: e.toString()));
    }
  }

  Future<void> _onAddHinhThucLoaiHinh(AddHinhThucLoaiHinh event, Emitter<HinhThucLoaiHinhState> emit) async {
    try {
      final hinhThucLoaiHinh = await hinhThucLoaiHinhRepository.addHinhThucLoaiHinh(event.hinhThucLoaiHinh);
      if (state is HinhThucLoaiHinhLoaded) {
        final updatedHinhThucLoaiHinhs = List<HinhThucLoaiHinh>.from((state as HinhThucLoaiHinhLoaded).hinhThucLoaiHinhs)..add(hinhThucLoaiHinh);
        emit(HinhThucLoaiHinhLoaded(hinhThucLoaiHinhs: updatedHinhThucLoaiHinhs));
      }
    } catch (e) {
      emit(HinhThucLoaiHinhError(message: e.toString()));
    }
  }

  Future<void> _onUpdateHinhThucLoaiHinh(UpdateHinhThucLoaiHinh event, Emitter<HinhThucLoaiHinhState> emit) async {
    try {
      final hinhThucLoaiHinh = await hinhThucLoaiHinhRepository.updateHinhThucLoaiHinh(event.hinhThucLoaiHinh);
      if (state is HinhThucLoaiHinhLoaded) {
        final updatedHinhThucLoaiHinhs = (state as HinhThucLoaiHinhLoaded).hinhThucLoaiHinhs.map((q) => q.idLhdn == hinhThucLoaiHinh.idLhdn ? hinhThucLoaiHinh : q).toList();
        emit(HinhThucLoaiHinhLoaded(hinhThucLoaiHinhs: updatedHinhThucLoaiHinhs));
      }
    } catch (e) {
      emit(HinhThucLoaiHinhError(message: e.toString()));
    }
  }

  Future<void> _onDeleteHinhThucLoaiHinh(DeleteHinhThucLoaiHinh event, Emitter<HinhThucLoaiHinhState> emit) async {
    try {
      await hinhThucLoaiHinhRepository.deleteHinhThucLoaiHinh(event.idLhdn);
      if (state is HinhThucLoaiHinhLoaded) {
        final updatedHinhThucLoaiHinhs = (state as HinhThucLoaiHinhLoaded).hinhThucLoaiHinhs.where((q) => q.idLhdn != event.idLhdn).toList();
        emit(HinhThucLoaiHinhLoaded(hinhThucLoaiHinhs: updatedHinhThucLoaiHinhs));
      }
    } catch (e) {
      emit(HinhThucLoaiHinhError(message: e.toString()));
    }
  }
}
