import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ttld/models/chapnoi/chapnoi_model.dart';
import 'package:ttld/repositories/chapnoi_repository.dart';
import 'package:ttld/features/auth/bloc/auth_bloc.dart';
import 'package:ttld/features/auth/bloc/auth_state.dart';
import 'package:ttld/core/di/injection.dart';

part 'chapnoi_event.dart';
part 'chapnoi_state.dart';

class ChapNoiBloc extends Bloc<ChapNoiEvent, ChapNoiState> {
  final ChapNoiRepository _chapNoiRepository;
  final AuthBloc _authBloc;

  ChapNoiBloc(this._chapNoiRepository)
      : _authBloc = locator<AuthBloc>(),
        super(ChapNoiInitial()) {
    on<ChapNoiFetchList>(_onFetchChapNoiList);
    on<ChapNoiCreate>(_onCreateChapNoi);
    on<ChapNoiDelete>(_onDeleteChapNoi);
  }

  Future<void> _onFetchChapNoiList(
      ChapNoiFetchList event, Emitter<ChapNoiState> emit) async {
    emit(ChapNoiLoading());
    try {
      final authState = _authBloc.state;
      String? idDoanhNghiep;
      String? idUv;
      int? limit;
      int? page;

      if (authState is AuthAuthenticated) {
        if (authState.userType == 'ntd') {
          idDoanhNghiep = authState.userId;
          limit = event.limit;
          page = event.page;
        } else if (authState.userType == 'ntv') {
          idUv = authState.userId;
        }
      }

      final response = await _chapNoiRepository.getChapNoiList(
        limit: limit,
        page: page,
        status: event.status,
        idTuyenDung: event.idTuyenDung,
        idDoanhNghiep: idDoanhNghiep,
        idUv: idUv,
      );
      emit(ChapNoiListLoaded(response.data ?? [], response.total ?? 0));
    } catch (e) {
      emit(ChapNoiError(e.toString()));
    }
  }

  Future<void> _onCreateChapNoi(
      ChapNoiCreate event, Emitter<ChapNoiState> emit) async {
    try {
      final response = await _chapNoiRepository.createChapNoi(event.chapNoi);
      if (response.data != null) {
        // After successful creation, fetch the updated list
        final authState = _authBloc.state;
        String? idDoanhNghiep;
        String? idUv;
        int? limit;
        int? page;

        if (authState is AuthAuthenticated) {
          if (authState.userType == 'ntd') {
            idDoanhNghiep = authState.userId;
            limit = 10;
            page = 1;
          } else if (authState.userType == 'ntv') {
            idUv = authState.userId;
          }
        }

        final listResponse = await _chapNoiRepository.getChapNoiList(
          limit: limit,
          page: page,
          status: null,
          idTuyenDung: null,
          idDoanhNghiep: idDoanhNghiep,
          idUv: idUv,
        );
        emit(ChapNoiListLoaded(
            listResponse.data ?? [], listResponse.total ?? 0));
      } else {
        emit(ChapNoiError(
            response.message ?? 'Failed to create ChapNoi: No data returned'));
      }
    } catch (e) {
      emit(ChapNoiError(e.toString()));
    }
  }

  Future<void> _onDeleteChapNoi(
      ChapNoiDelete event, Emitter<ChapNoiState> emit) async {
    try {
      final response = await _chapNoiRepository.deleteChapNoi(event.id);
      if (response.success == true) {
        // After successful deletion, fetch the updated list
        final authState = _authBloc.state;
        String? idDoanhNghiep;
        String? idUv;
        int? limit;
        int? page;

        if (authState is AuthAuthenticated) {
          if (authState.userType == 'ntd') {
            idDoanhNghiep = authState.userId;
            limit = 10;
            page = 1;
          } else if (authState.userType == 'ntv') {
            idUv = authState.userId;
          }
        }

        final listResponse = await _chapNoiRepository.getChapNoiList(
          limit: limit,
          page: page,
          status: null,
          idTuyenDung: null,
          idDoanhNghiep: idDoanhNghiep,
          idUv: idUv,
        );
        emit(ChapNoiListLoaded(
            listResponse.data ?? [], listResponse.total ?? 0));
      } else {
        emit(ChapNoiError(response.message ?? 'Failed to delete ChapNoi'));
      }
    } catch (e) {
      emit(ChapNoiError(e.toString()));
    }
  }
}
