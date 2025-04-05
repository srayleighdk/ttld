import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ttld/models/hinh_thuc_lam_viec_model.dart';
import 'package:ttld/repositories/hinh_thuc_lam_viec_repository.dart';

part 'hinh_thuc_lam_viec_event.dart';
part 'hinh_thuc_lam_viec_state.dart';

class HinhThucLamViecBloc extends Bloc<HinhThucLamViecEvent, HinhThucLamViecState> {
  final HinhThucLamViecRepository _repository;

  HinhThucLamViecBloc(this._repository) : super(HinhThucLamViecInitial()) {
    on<LoadHinhThucLamViecs>(_onLoadHinhThucLamViecs);
    on<AddHinhThucLamViec>(_onAddHinhThucLamViec);
    on<UpdateHinhThucLamViec>(_onUpdateHinhThucLamViec);
    on<DeleteHinhThucLamViec>(_onDeleteHinhThucLamViec);
  }

  Future<void> _onLoadHinhThucLamViecs(
      LoadHinhThucLamViecs event, Emitter<HinhThucLamViecState> emit) async {
    emit(HinhThucLamViecLoading());
    try {
      final hinhThucLamViecs = await _repository.getHinhThucLamViecs();
      emit(HinhThucLamViecLoaded(hinhThucLamViecs));
    } catch (e) {
      emit(HinhThucLamViecError('Failed to load Hình thức làm việc: ${e.toString()}'));
    }
  }

  Future<void> _onAddHinhThucLamViec(
      AddHinhThucLamViec event, Emitter<HinhThucLamViecState> emit) async {
    try {
      await _repository.addHinhThucLamViec(event.hinhThucLamViec);
      emit(HinhThucLamViecOperationSuccess());
      add(LoadHinhThucLamViecs()); // Reload data
    } catch (e) {
      emit(HinhThucLamViecError('Failed to add Hình thức làm việc: ${e.toString()}'));
      if (state is HinhThucLamViecLoaded) {
         emit(HinhThucLamViecLoaded((state as HinhThucLamViecLoaded).hinhThucLamViecs));
      }
    }
  }

  Future<void> _onUpdateHinhThucLamViec(
      UpdateHinhThucLamViec event, Emitter<HinhThucLamViecState> emit) async {
     try {
      await _repository.updateHinhThucLamViec(event.hinhThucLamViec);
      emit(HinhThucLamViecOperationSuccess());
      add(LoadHinhThucLamViecs()); // Reload data
    } catch (e) {
      emit(HinhThucLamViecError('Failed to update Hình thức làm việc: ${e.toString()}'));
       if (state is HinhThucLamViecLoaded) {
         emit(HinhThucLamViecLoaded((state as HinhThucLamViecLoaded).hinhThucLamViecs));
       }
    }
  }

  Future<void> _onDeleteHinhThucLamViec(
      DeleteHinhThucLamViec event, Emitter<HinhThucLamViecState> emit) async {
     try {
      await _repository.deleteHinhThucLamViec(event.id);
      emit(HinhThucLamViecOperationSuccess());
      add(LoadHinhThucLamViecs()); // Reload data
    } catch (e) {
      emit(HinhThucLamViecError('Failed to delete Hình thức làm việc: ${e.toString()}'));
       if (state is HinhThucLamViecLoaded) {
         emit(HinhThucLamViecLoaded((state as HinhThucLamViecLoaded).hinhThucLamViecs));
       }
    }
  }
}
