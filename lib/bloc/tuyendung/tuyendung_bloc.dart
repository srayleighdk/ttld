import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/ntd_tuyendung/ntd_tuyendung_model.dart';
import 'package:ttld/repositories/tuyendung_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tuyendung_event.dart';
part 'tuyendung_state.dart';
part 'tuyendung_bloc.freezed.dart';

class TuyenDungBloc extends Bloc<TuyenDungEvent, TuyenDungState> {
  final TuyenDungRepository _repository;

  TuyenDungBloc(this._repository) : super(TuyenDungInitial()) {
    on<FetchTuyenDungList>(_onFetchTuyenDungList);
    on<CreateTuyenDung>(_onCreateTuyenDung);
    on<UpdateTuyenDung>(_onUpdateTuyenDung);
    on<DeleteTuyenDung>(_onDeleteTuyenDung);
  }

  Future<void> _onFetchTuyenDungList(
    FetchTuyenDungList event,
    Emitter<TuyenDungState> emit,
  ) async {
    emit(TuyenDungLoading());
    try {
      final tuyenDungList = await _repository.getTuyenDungList(event.ntdId);
      emit(TuyenDungLoaded(tuyenDungList));
    } catch (e) {
      emit(TuyenDungError(e.toString()));
    }
  }

  Future<void> _onCreateTuyenDung(
    CreateTuyenDung event,
    Emitter<TuyenDungState> emit,
  ) async {
    emit(TuyenDungLoading());
    try {
      final newTuyenDung = await _repository.createTuyenDung(event.tuyenDung);
      final currentState = state as TuyenDungLoaded;
      emit(TuyenDungLoaded([...currentState.tuyenDungList, newTuyenDung]));
    } catch (e) {
      emit(TuyenDungError(e.toString()));
    }
  }

  Future<void> _onUpdateTuyenDung(
    UpdateTuyenDung event,
    Emitter<TuyenDungState> emit,
  ) async {
    emit(TuyenDungLoading());
    try {
      final updatedTuyenDung =
          await _repository.updateTuyenDung(event.tuyenDung);
      final currentState = state as TuyenDungLoaded;
      final newList = currentState.tuyenDungList
          .map((td) => td.idTuyenDung == updatedTuyenDung.idTuyenDung
              ? updatedTuyenDung
              : td)
          .toList();
      emit(TuyenDungLoaded(newList));
    } catch (e) {
      emit(TuyenDungError(e.toString()));
    }
  }

  Future<void> _onDeleteTuyenDung(
    DeleteTuyenDung event,
    Emitter<TuyenDungState> emit,
  ) async {
    emit(TuyenDungLoading());
    try {
      await _repository.deleteTuyenDung(event.idTuyenDung);
      final currentState = state as TuyenDungLoaded;
      final newList = currentState.tuyenDungList
          .where((td) => td.idTuyenDung != event.idTuyenDung)
          .toList();
      emit(TuyenDungLoaded(newList));
    } catch (e) {
      emit(TuyenDungError(e.toString()));
    }
  }
}
