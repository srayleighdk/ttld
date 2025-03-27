import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/m01apli/m01apli_model.dart';
import '../../repositories/m01apli_repository.dart';

part 'm01apli_event.dart';
part 'm01apli_state.dart';

class M01APliBloc extends Bloc<M01APliEvent, M01APliState> {
  final M01APliRepository _repository;

  M01APliBloc(this._repository) : super(M01APliInitial()) {
    on<LoadM01APlis>(_onLoadM01APlis);
    on<CreateM01APli>(_onCreateM01APli);
    on<UpdateM01APli>(_onUpdateM01APli);
    on<DeleteM01APli>(_onDeleteM01APli);
  }

  Future<void> _onLoadM01APlis(
    LoadM01APlis event,
    Emitter<M01APliState> emit,
  ) async {
    emit(M01APliLoading());
    try {
      final plis = await _repository.fetchM01APlis();
      emit(M01APliLoadSuccess(plis));
    } catch (e) {
      emit(M01APliOperationFailure(e.toString()));
    }
  }

  Future<void> _onCreateM01APli(
    CreateM01APli event,
    Emitter<M01APliState> emit,
  ) async {
    emit(M01APliLoading());
    try {
      final newPli = await _repository.createM01APli(event.pli);
      emit(M01APliCreateSuccess(newPli));
    } catch (e) {
      emit(M01APliOperationFailure(e.toString()));
    }
  }

  Future<void> _onUpdateM01APli(
    UpdateM01APli event,
    Emitter<M01APliState> emit,
  ) async {
    emit(M01APliLoading());
    try {
      final updatedPli = await _repository.updateM01APli(event.pli);
      emit(M01APliUpdateSuccess(updatedPli));
    } catch (e) {
      emit(M01APliOperationFailure(e.toString()));
    }
  }

  Future<void> _onDeleteM01APli(
    DeleteM01APli event,
    Emitter<M01APliState> emit,
  ) async {
    emit(M01APliLoading());
    try {
      await _repository.deleteM01APli(event.idphieu);
      emit(M01APliDeleteSuccess());
    } catch (e) {
      emit(M01APliOperationFailure(e.toString()));
    }
  }
}
