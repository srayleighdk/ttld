import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/m01pli/m01pli_model.dart';
import '../../repositories/m01pli_repository.dart';

part 'm01pli_event.dart';
part 'm01pli_state.dart';

class M01PliBloc extends Bloc<M01PliEvent, M01PliState> {
  final M01PliRepository _repository;

  M01PliBloc(this._repository) : super(M01PliInitial()) {
    on<LoadM01Plis>(_onLoadM01Plis);
    on<CreateM01Pli>(_onCreateM01Pli);
    on<UpdateM01Pli>(_onUpdateM01Pli);
    on<DeleteM01Pli>(_onDeleteM01Pli);
  }

  Future<void> _onLoadM01Plis(
    LoadM01Plis event,
    Emitter<M01PliState> emit,
  ) async {
    emit(M01PliLoading());
    try {
      final plis = await _repository.fetchM01Plis();
      // emit(M01PliLoadSuccess(plis));
    } catch (e) {
      emit(M01PliOperationFailure(e.toString()));
    }
  }

  Future<void> _onCreateM01Pli(
    CreateM01Pli event,
    Emitter<M01PliState> emit,
  ) async {
    emit(M01PliLoading());
    try {
      final newPli = await _repository.createM01Pli(event.pli);
      emit(M01PliCreateSuccess(newPli));
    } catch (e) {
      emit(M01PliOperationFailure(e.toString()));
    }
  }

  Future<void> _onUpdateM01Pli(
    UpdateM01Pli event,
    Emitter<M01PliState> emit,
  ) async {
    emit(M01PliLoading());
    try {
      final updatedPli = await _repository.updateM01Pli(event.pli);
      emit(M01PliUpdateSuccess(updatedPli));
    } catch (e) {
      emit(M01PliOperationFailure(e.toString()));
    }
  }

  Future<void> _onDeleteM01Pli(
    DeleteM01Pli event,
    Emitter<M01PliState> emit,
  ) async {
    emit(M01PliLoading());
    try {
      await _repository.deleteM01Pli(event.idphieu);
      emit(M01PliDeleteSuccess());
    } catch (e) {
      emit(M01PliOperationFailure(e.toString()));
    }
  }
}
