import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ttld/models/ky_nang_mem_model.dart';
import 'package:ttld/repositories/ky_nang_mem_repository.dart';

part 'ky_nang_mem_event.dart';
part 'ky_nang_mem_state.dart';

class KyNangMemBloc extends Bloc<KyNangMemEvent, KyNangMemState> {
  final KyNangMemRepository _repository;

  KyNangMemBloc(this._repository) : super(KyNangMemInitial()) {
    on<LoadKyNangMems>(_onLoadKyNangMems);
    on<AddKyNangMem>(_onAddKyNangMem);
    on<UpdateKyNangMem>(_onUpdateKyNangMem);
    on<DeleteKyNangMem>(_onDeleteKyNangMem);
  }

  Future<void> _onLoadKyNangMems(
      LoadKyNangMems event, Emitter<KyNangMemState> emit) async {
    emit(KyNangMemLoading());
    try {
      final kyNangMems = await _repository.getKyNangMems();
      emit(KyNangMemLoaded(kyNangMems));
    } catch (e) {
      emit(KyNangMemError('Failed to load Kỹ năng mềm: ${e.toString()}'));
    }
  }

  Future<void> _onAddKyNangMem(
      AddKyNangMem event, Emitter<KyNangMemState> emit) async {
    try {
      // Optionally emit loading state if needed
      await _repository.addKyNangMem(event.kyNangMem);
      emit(KyNangMemOperationSuccess());
      // Reload data after adding
      add(LoadKyNangMems());
    } catch (e) {
      emit(KyNangMemError('Failed to add Kỹ năng mềm: ${e.toString()}'));
      // Optionally re-emit the previous loaded state if available
      if (state is KyNangMemLoaded) {
         emit(KyNangMemLoaded((state as KyNangMemLoaded).kyNangMems));
      }
    }
  }

  Future<void> _onUpdateKyNangMem(
      UpdateKyNangMem event, Emitter<KyNangMemState> emit) async {
     try {
       // Optionally emit loading state if needed
      await _repository.updateKyNangMem(event.kyNangMem);
      emit(KyNangMemOperationSuccess());
       // Reload data after updating
      add(LoadKyNangMems());
    } catch (e) {
      emit(KyNangMemError('Failed to update Kỹ năng mềm: ${e.toString()}'));
       // Optionally re-emit the previous loaded state if available
       if (state is KyNangMemLoaded) {
         emit(KyNangMemLoaded((state as KyNangMemLoaded).kyNangMems));
       }
    }
  }

  Future<void> _onDeleteKyNangMem(
      DeleteKyNangMem event, Emitter<KyNangMemState> emit) async {
     try {
       // Optionally emit loading state if needed
      await _repository.deleteKyNangMem(event.id);
      emit(KyNangMemOperationSuccess());
       // Reload data after deleting
      add(LoadKyNangMems());
    } catch (e) {
      emit(KyNangMemError('Failed to delete Kỹ năng mềm: ${e.toString()}'));
       // Optionally re-emit the previous loaded state if available
       if (state is KyNangMemLoaded) {
         emit(KyNangMemLoaded((state as KyNangMemLoaded).kyNangMems));
       }
    }
  }
}
