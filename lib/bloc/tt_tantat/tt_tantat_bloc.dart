import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/tttantat/tttantat.dart';
import 'package:ttld/repositories/tt_tantat/tt_tantat_repository.dart';

part 'tt_tantat_event.dart';
part 'tt_tantat_state.dart';

class TTTanTatBloc extends Bloc<TTTanTatEvent, TTTanTatState> {
  final TTTanTatRepository ttTanTatRepository;

  TTTanTatBloc({required this.ttTanTatRepository}) : super(TTTanTatInitial()) {
    on<LoadTTTanTats>(_onLoadTTTanTats);
    on<AddTTTanTat>(_onAddTTTanTat);
    on<UpdateTTTanTat>(_onUpdateTTTanTat);
    on<DeleteTTTanTat>(_onDeleteTTTanTat);
  }

  Future<void> _onLoadTTTanTats(LoadTTTanTats event, Emitter<TTTanTatState> emit) async {
    emit(TTTanTatLoading());
    try {
      final ttTanTats = await ttTanTatRepository.getTTTanTats();
      emit(TTTanTatLoaded(ttTanTats: ttTanTats));
    } catch (e) {
      emit(TTTanTatError(message: e.toString()));
    }
  }

  Future<void> _onAddTTTanTat(AddTTTanTat event, Emitter<TTTanTatState> emit) async {
    try {
      final ttTanTat = await ttTanTatRepository.addTTTanTat(event.ttTanTat);
      if (state is TTTanTatLoaded) {
        final updatedTTTanTats = List<TtTantat>.from((state as TTTanTatLoaded).ttTanTats)..add(ttTanTat);
        emit(TTTanTatLoaded(ttTanTats: updatedTTTanTats));
      }
    } catch (e) {
      emit(TTTanTatError(message: e.toString()));
    }
  }

  Future<void> _onUpdateTTTanTat(UpdateTTTanTat event, Emitter<TTTanTatState> emit) async {
    try {
      final ttTanTat = await ttTanTatRepository.updateTTTanTat(event.ttTanTat);
      if (state is TTTanTatLoaded) {
        final updatedTTTanTats = (state as TTTanTatLoaded).ttTanTats.map((q) => q.id == event.ttTanTat.id ? event.ttTanTat : q).toList();
        emit(TTTanTatLoaded(ttTanTats: updatedTTTanTats));
      }
    } catch (e) {
      emit(TTTanTatError(message: e.toString()));
    }
  }

  Future<void> _onDeleteTTTanTat(DeleteTTTanTat event, Emitter<TTTanTatState> emit) async {
    try {
      await ttTanTatRepository.deleteTTTanTat(event.id);
      if (state is TTTanTatLoaded) {
        final updatedTTTanTats = (state as TTTanTatLoaded).ttTanTats.where((q) => q.id != event.id).toList();
        emit(TTTanTatLoaded(ttTanTats: updatedTTTanTats));
      }
    } catch (e) {
      emit(TTTanTatError(message: e.toString()));
    }
  }
}
