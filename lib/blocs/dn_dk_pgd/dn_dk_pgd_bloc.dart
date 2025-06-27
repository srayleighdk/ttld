import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/blocs/dn_dk_pgd/dn_dk_pgd_event.dart';
import 'package:ttld/blocs/dn_dk_pgd/dn_dk_pgd_state.dart';
import 'package:ttld/repositories/dn_dk_pgd_repository.dart';

class DnDkPgdBloc extends Bloc<DnDkPgdEvent, DnDkPgdState> {
  final DnDkPgdRepository _repository;

  DnDkPgdBloc(this._repository) : super(DnDkPgdInitial()) {
    on<GetDnDkPgdList>(_onGetDnDkPgdList);
    on<CreateDnDkPgd>(_onCreateDnDkPgd);
    on<UpdateDnDkPgd>(_onUpdateDnDkPgd);
    on<DeleteDnDkPgd>(_onDeleteDnDkPgd);
  }

  Future<void> _onGetDnDkPgdList(
    GetDnDkPgdList event,
    Emitter<DnDkPgdState> emit,
  ) async {
    try {
      emit(DnDkPgdLoading());
      final response = await _repository.getDnDkPgdList();
      emit(DnDkPgdListLoaded(response.data ?? []));
    } catch (e) {
      emit(DnDkPgdError(e.toString()));
    }
  }

  Future<void> _onCreateDnDkPgd(
    CreateDnDkPgd event,
    Emitter<DnDkPgdState> emit,
  ) async {
    try {
      emit(DnDkPgdLoading());
      final response = await _repository.createDnDkPgd(event.dnDkPgd);
      if (response.data != null) {
        emit(DnDkPgdCreated(response.data!));
      } else {
        emit(const DnDkPgdError('Failed to create DN đăng ký Phiên GD'));
      }
    } catch (e) {
      emit(DnDkPgdError(e.toString()));
    }
  }

  Future<void> _onUpdateDnDkPgd(
    UpdateDnDkPgd event,
    Emitter<DnDkPgdState> emit,
  ) async {
    try {
      emit(DnDkPgdLoading());
      final response = await _repository.updateDnDkPgd(event.dnDkPgd);
      if (response.data != null) {
        emit(DnDkPgdUpdated(response.data!));
      } else {
        emit(const DnDkPgdError('Failed to update DN đăng ký Phiên GD'));
      }
    } catch (e) {
      emit(DnDkPgdError(e.toString()));
    }
  }

  Future<void> _onDeleteDnDkPgd(
    DeleteDnDkPgd event,
    Emitter<DnDkPgdState> emit,
  ) async {
    try {
      emit(DnDkPgdLoading());
      final response = await _repository.deleteDnDkPgd(event.id);
      emit(DnDkPgdDeleted(response.data ?? false));
    } catch (e) {
      emit(DnDkPgdError(e.toString()));
    }
  }
}
