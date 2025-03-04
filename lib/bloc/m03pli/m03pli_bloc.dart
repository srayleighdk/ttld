import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/bloc/m03pli/m03pli_event.dart';
import 'package:ttld/bloc/m03pli/m03pli_state.dart';
import 'package:ttld/models/m03pli_model.dart';
import 'package:ttld/repositories/m03pli/m03pli_repository.dart';

class M03PLIBloc extends Bloc<M03PLIEvent, M03PLIState> {
  final M03PLIRepository _m03pliRepository;

  M03PLIBloc(this._m03pliRepository) : super(M03PLIInitial()) {
    on<LoadM03PLIs>(_onLoadM03PLIs);
    on<CreateM03PLI>(_onCreateM03PLI);
    on<UpdateM03PLI>(_onUpdateM03PLI);
    on<DeleteM03PLI>(_onDeleteM03PLI);
  }

  Future<void> _onLoadM03PLIs(LoadM03PLIs event, Emitter<M03PLIState> emit) async {
    emit(M03PLILoading());
    try {
      final m03plis = await _m03pliRepository.getM03PLIs();
      emit(M03PLILoaded(m03plis));
    } catch (e) {
      emit(M03PLIError(e.toString()));
    }
  }

  Future<void> _onCreateM03PLI(CreateM03PLI event, Emitter<M03PLIState> emit) async {
    try {
      await _m03pliRepository.createM03PLI(event.m03pli);
      final m03plis = await _m03pliRepository.getM03PLIs();
      emit(M03PLILoaded(m03plis));
    } catch (e) {
      emit(M03PLIError(e.toString()));
    }
  }

  Future<void> _onUpdateM03PLI(UpdateM03PLI event, Emitter<M03PLIState> emit) async {
    try {
      await _m03pliRepository.updateM03PLI(event.m03pli);
      final m03plis = await _m03pliRepository.getM03PLIs();
      emit(M03PLILoaded(m03plis));
    } catch (e) {
      emit(M03PLIError(e.toString()));
    }
  }

  Future<void> _onDeleteM03PLI(DeleteM03PLI event, Emitter<M03PLIState> emit) async {
    try {
      await _m03pliRepository.deleteM03PLI(event.id);
      final m03plis = await _m03pliRepository.getM03PLIs();
      emit(M03PLILoaded(m03plis));
    } catch (e) {
      emit(M03PLIError(e.toString()));
    }
  }
}
