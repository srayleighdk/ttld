import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/nguon_vieclam_model.dart';
import 'package:ttld/repositories/nguon_vieclam/nguon_vieclam_repository.dart';

part 'nguon_vieclam_event.dart';
part 'nguon_vieclam_state.dart';

class NguonViecLamBloc extends Bloc<NguonViecLamEvent, NguonViecLamState> {
  final NguonViecLamRepository nguonViecLamRepository;

  NguonViecLamBloc({required this.nguonViecLamRepository}) : super(NguonViecLamInitial()) {
    on<LoadNguonViecLams>(_onLoadNguonViecLams);
    on<AddNguonViecLam>(_onAddNguonViecLam);
    on<UpdateNguonViecLam>(_onUpdateNguonViecLam);
    on<DeleteNguonViecLam>(_onDeleteNguonViecLam);
  }

  Future<void> _onLoadNguonViecLams(LoadNguonViecLams event, Emitter<NguonViecLamState> emit) async {
    emit(NguonViecLamLoading());
    try {
      final nguonViecLams = await nguonViecLamRepository.getNguonViecLams();
      emit(NguonViecLamLoaded(nguonViecLams: nguonViecLams));
    } catch (e) {
      emit(NguonViecLamError(message: e.toString()));
    }
  }

  Future<void> _onAddNguonViecLam(AddNguonViecLam event, Emitter<NguonViecLamState> emit) async {
    try {
      final nguonViecLam = await nguonViecLamRepository.addNguonViecLam(event.nguonViecLam);
      if (state is NguonViecLamLoaded) {
        final updatedNguonViecLams = List<NguonViecLam>.from((state as NguonViecLamLoaded).nguonViecLams)..add(nguonViecLam);
        emit(NguonViecLamLoaded(nguonViecLams: updatedNguonViecLams));
      }
    } catch (e) {
      emit(NguonViecLamError(message: e.toString()));
    }
  }

  Future<void> _onUpdateNguonViecLam(UpdateNguonViecLam event, Emitter<NguonViecLamState> emit) async {
    try {
      final nguonViecLam = await nguonViecLamRepository.updateNguonViecLam(event.nguonViecLam);
      if (state is NguonViecLamLoaded) {
        final updatedNguonViecLams = (state as NguonViecLamLoaded).nguonViecLams.map((q) => q.maNguonVlt == nguonViecLam.maNguonVlt ? nguonViecLam : q).toList();
        emit(NguonViecLamLoaded(nguonViecLams: updatedNguonViecLams));
      }
    } catch (e) {
      emit(NguonViecLamError(message: e.toString()));
    }
  }

  Future<void> _onDeleteNguonViecLam(DeleteNguonViecLam event, Emitter<NguonViecLamState> emit) async {
    try {
      await nguonViecLamRepository.deleteNguonViecLam(event.maNguonVlt.toString());
      if (state is NguonViecLamLoaded) {
        final updatedNguonViecLams = (state as NguonViecLamLoaded).nguonViecLams.where((q) => q.maNguonVlt != event.maNguonVlt).toList();
        emit(NguonViecLamLoaded(nguonViecLams: updatedNguonViecLams));
      }
    } catch (e) {
      emit(NguonViecLamError(message: e.toString()));
    }
  }
}
