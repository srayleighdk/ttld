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
    on<UpdateTuyenDungForm>(_onUpdateTuyenDungForm);
    on<DeleteTuyenDung>(_onDeleteTuyenDung);
  }

  Future<void> _onFetchTuyenDungList(
    FetchTuyenDungList event,
    Emitter<TuyenDungState> emit,
  ) async {
    emit(TuyenDungLoading());
    try {
      final result = await _repository.getTuyenDungList(
        event.ntdId,
        idUv: event.idUv,
        limit: event.limit,
        page: event.page,
        search: event.search,
        status: event.status,
        duyet: event.duyet,
        id: event.id,
      );
      
      final tuyenDungList = result['data'] as List<NTDTuyenDung>;
      final pagination = result['pagination'] as Map<String, dynamic>;
      
      emit(TuyenDungLoaded(
        tuyenDungList,
        currentPage: pagination['currentPage'] as int,
        totalPages: pagination['totalPages'] as int,
        totalItems: pagination['totalItems'] as int,
        limit: pagination['limit'] as int,
      ));
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
      await _repository.createTuyenDung(event.tuyenDung);
      // After creating, fetch the complete list to ensure we have all data
      final result =
          await _repository.getTuyenDungList(event.tuyenDung.idDoanhNghiep);
      final tuyenDungList = result['data'] as List<NTDTuyenDung>;
      final pagination = result['pagination'] as Map<String, dynamic>;
      
      emit(TuyenDungLoaded(
        tuyenDungList,
        currentPage: pagination['currentPage'] as int,
        totalPages: pagination['totalPages'] as int,
        totalItems: pagination['totalItems'] as int,
        limit: pagination['limit'] as int,
      ));
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
      final updatedList = currentState.tuyenDungList.map((td) {
        return td.idTuyenDung == updatedTuyenDung.idTuyenDung
            ? updatedTuyenDung
            : td;
      }).toList();
      emit(TuyenDungLoaded(
        updatedList,
        currentPage: currentState.currentPage,
        totalPages: currentState.totalPages,
        totalItems: currentState.totalItems,
        limit: currentState.limit,
      ));
    } catch (e) {
      emit(TuyenDungError(e.toString()));
    }
  }

  Future<void> _onUpdateTuyenDungForm(
    UpdateTuyenDungForm event,
    Emitter<TuyenDungState> emit,
  ) async {
    if (state is CreateTuyenDungState) {
      final currentState = state as CreateTuyenDungState;
      emit(currentState.copyWith(tuyenDung: event.tuyenDung));
    }
  }

  Future<void> _onDeleteTuyenDung(
    DeleteTuyenDung event,
    Emitter<TuyenDungState> emit,
  ) async {
    emit(TuyenDungLoading());
    try {
      await _repository.deleteTuyenDung(event.idTuyenDung);
      // After deleting, fetch the complete list to ensure we have all data
      final result = await _repository.getTuyenDungList(event.userId);
      final tuyenDungList = result['data'] as List<NTDTuyenDung>;
      final pagination = result['pagination'] as Map<String, dynamic>;
      
      emit(TuyenDungLoaded(
        tuyenDungList,
        currentPage: pagination['currentPage'] as int,
        totalPages: pagination['totalPages'] as int,
        totalItems: pagination['totalItems'] as int,
        limit: pagination['limit'] as int,
      ));
    } catch (e) {
      emit(TuyenDungError(e.toString()));
    }
  }
}
