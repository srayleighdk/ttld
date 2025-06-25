import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/nguon_thuthap_model.dart';
import 'package:ttld/repositories/nguon_thuthap/nguon_thuthap_repository.dart';

part 'nguon_thuthap_event.dart';
part 'nguon_thuthap_state.dart';

class NguonThuThapBloc extends Bloc<NguonThuThapEvent, NguonThuThapState> {
  final NguonThuThapRepository nguonThuThapRepository;

  NguonThuThapBloc(this.nguonThuThapRepository) : super(NguonThuThapInitial()) {
    on<LoadNguonThuThaps>(_onLoadNguonThuThaps);
    on<AddNguonThuThap>(_onAddNguonThuThap);
    on<UpdateNguonThuThap>(_onUpdateNguonThuThap);
    on<DeleteNguonThuThap>(_onDeleteNguonThuThap);
  }

  Future<void> _onLoadNguonThuThaps(
      LoadNguonThuThaps event, Emitter<NguonThuThapState> emit) async {
    emit(NguonThuThapLoading());
    try {
      final nguonThuThaps = await nguonThuThapRepository.getNguonThuThaps();
      emit(NguonThuThapLoaded(nguonThuThaps: nguonThuThaps));
    } catch (e) {
      emit(NguonThuThapError(message: e.toString()));
    }
  }

  Future<void> _onAddNguonThuThap(
      AddNguonThuThap event, Emitter<NguonThuThapState> emit) async {
    try {
      final nguonThuThap =
          await nguonThuThapRepository.addNguonThuThap(event.nguonThuThap);
      if (state is NguonThuThapLoaded) {
        final updatedNguonThuThaps =
            List<NguonThuThap>.from((state as NguonThuThapLoaded).nguonThuThaps)
              ..add(nguonThuThap);
        emit(NguonThuThapLoaded(nguonThuThaps: updatedNguonThuThaps));
      }
    } catch (e) {
      emit(NguonThuThapError(message: e.toString()));
    }
  }

  Future<void> _onUpdateNguonThuThap(
      UpdateNguonThuThap event, Emitter<NguonThuThapState> emit) async {
    try {
      final nguonThuThap =
          await nguonThuThapRepository.updateNguonThuThap(event.nguonThuThap);
      if (state is NguonThuThapLoaded) {
        final updatedNguonThuThaps = (state as NguonThuThapLoaded)
            .nguonThuThaps
            .map((q) => q.id == nguonThuThap.id ? nguonThuThap : q)
            .toList();
        emit(NguonThuThapLoaded(nguonThuThaps: updatedNguonThuThaps));
      }
    } catch (e) {
      emit(NguonThuThapError(message: e.toString()));
    }
  }

  Future<void> _onDeleteNguonThuThap(
      DeleteNguonThuThap event, Emitter<NguonThuThapState> emit) async {
    try {
      await nguonThuThapRepository.deleteNguonThuThap(event.id);
      if (state is NguonThuThapLoaded) {
        final updatedNguonThuThaps = (state as NguonThuThapLoaded)
            .nguonThuThaps
            .where((q) => q.id != event.id)
            .toList();
        emit(NguonThuThapLoaded(nguonThuThaps: updatedNguonThuThaps));
      }
    } catch (e) {
      emit(NguonThuThapError(message: e.toString()));
    }
  }
}
