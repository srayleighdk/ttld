import 'package:bloc/bloc.dart';
import 'package:your_app_name/bloc/muc_luong/muc_luong_event.dart';
import 'package:your_app_name/bloc/muc_luong/muc_luong_state.dart';
import 'package:your_app_name/models/muc_luong_mm.dart'; // Replace with your actual import
import 'package:your_app_name/repositories/muc_luong/muc_luong_repository.dart'; // Replace with your actual import

class MucLuongBloc extends Bloc<MucLuongEvent, MucLuongState> {
  final MucLuongRepository mucLuongRepository;

  MucLuongBloc({required this.mucLuongRepository}) : super(MucLuongInitial()) {
    on<LoadMucLuongs>(_onLoadMucLuongs);
    on<CreateMucLuong>(_onCreateMucLuong);
    on<UpdateMucLuong>(_onUpdateMucLuong);
    on<DeleteMucLuong>(_onDeleteMucLuong);
  }

  Future<void> _onLoadMucLuongs(LoadMucLuongs event, Emitter<MucLuongState> emit) async {
    emit(MucLuongLoading());
    try {
      final mucLuongs = await mucLuongRepository.getMucLuongs();
      emit(MucLuongLoaded(mucLuongs: mucLuongs));
    } catch (e) {
      emit(MucLuongError(message: e.toString()));
    }
  }

  Future<void> _onCreateMucLuong(CreateMucLuong event, Emitter<MucLuongState> emit) async {
    try {
      final createdMucLuong = await mucLuongRepository.createMucLuong(event.mucLuong);
      // Optionally, reload the list or update the state optimistically
      if (state is MucLuongLoaded) {
        final updatedMucLuongs = List<MucLuongMM>.from((state as MucLuongLoaded).mucLuongs)..add(createdMucLuong);
        emit(MucLuongLoaded(mucLuongs: updatedMucLuongs));
      }
    } catch (e) {
      emit(MucLuongError(message: e.toString()));
    }
  }

  Future<void> _onUpdateMucLuong(UpdateMucLuong event, Emitter<MucLuongState> emit) async {
    try {
      final updatedMucLuong = await mucLuongRepository.updateMucLuong(event.mucLuong);
      // Optionally, reload the list or update the state optimistically
      if (state is MucLuongLoaded) {
        final updatedMucLuongs = (state as MucLuongLoaded).mucLuongs.map((mucLuong) {
          return mucLuong.idMucLuong == updatedMucLuong.idMucLuong ? updatedMucLuong : mucLuong;
        }).toList();
        emit(MucLuongLoaded(mucLuongs: updatedMucLuongs));
      }
    } catch (e) {
      emit(MucLuongError(message: e.toString()));
    }
  }

  Future<void> _onDeleteMucLuong(DeleteMucLuong event, Emitter<MucLuongState> emit) async {
    try {
      await mucLuongRepository.deleteMucLuong(event.id);
      // Optionally, reload the list or update the state optimistically
      if (state is MucLuongLoaded) {
        final updatedMucLuongs = (state as MucLuongLoaded).mucLuongs.where((mucLuong) => mucLuong.idMucLuong != event.id).toList();
        emit(MucLuongLoaded(mucLuongs: updatedMucLuongs));
      }
    } catch (e) {
      emit(MucLuongError(message: e.toString()));
    }
  }
}
