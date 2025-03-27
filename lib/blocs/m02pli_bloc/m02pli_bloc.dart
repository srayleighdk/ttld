import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/m02pli/m02pli_model.dart';
import '../../repositories/m02pli_repository.dart';

part 'm02pli_event.dart';
part 'm02pli_state.dart';

class M02PliBloc extends Bloc<M02PliEvent, M02PliState> {
  final M02PliRepository _repository;

  M02PliBloc(this._repository) : super(M02PliInitial()) {
    on<LoadM02Plis>(_onLoadM02Plis);
    on<CreateM02Pli>(_onCreateM02Pli);
    on<UpdateM02Pli>(_onUpdateM02Pli);
    on<DeleteM02Pli>(_onDeleteM02Pli);
  }

  Future<void> _onLoadM02Plis(
    LoadM02Plis event,
    Emitter<M02PliState> emit,
  ) async {
    emit(M02PliLoading());
    try {
      final plis = await _repository.fetchM02Plis();
      emit(M02PliLoadSuccess(plis));
    } catch (e) {
      emit(M02PliOperationFailure(e.toString()));
    }
  }

  Future<void> _onCreateM02Pli(
    CreateM02Pli event,
    Emitter<M02PliState> emit,
  ) async {
    emit(M02PliLoading());
    try {
      final newPli = await _repository.createM02Pli(event.pli);
      emit(M02PliCreateSuccess(newPli));
    } catch (e) {
      emit(M02PliOperationFailure(e.toString()));
    }
  }

  Future<void> _onUpdateM02Pli(
    UpdateM02Pli event,
    Emitter<M02PliState> emit,
  ) async {
    emit(M02PliLoading());
    try {
      final updatedPli = await _repository.updateM02Pli(event.pli);
      emit(M02PliUpdateSuccess(updatedPli));
    } catch (e) {
      emit(M02PliOperationFailure(e.toString()));
    }
  }

  Future<void> _onDeleteM02Pli(
    DeleteM02Pli event,
    Emitter<M02PliState> emit,
  ) async {
    emit(M02PliLoading());
    try {
      await _repository.deleteM02Pli(event.idphieu);
      emit(M02PliDeleteSuccess());
    } catch (e) {
      emit(M02PliOperationFailure(e.toString()));
    }
  }
}
