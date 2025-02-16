import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/core/models/paginated_reponse.dart';
import 'package:ttld/features/ds-ld/repositories/ld_repository.dart';

import 'package:ttld/features/ds-ld/models/ld.dart';

part 'ld_event.dart';
part 'ld_state.dart';

class LdBloc extends Bloc<LdEvent, LdState> {
  final LdRepository repository;

  LdBloc(this.repository) : super(LdInitial()) {
    on<InitializeNewLd>(_onInitializeNewLd);
    on<LoadLd>(_onLoadLd);
    on<SaveLd>(_onSaveLd);
    on<UpdateLd>(_onUpdateLd);
    on<DeleteLd>(_onDeleteLd);
    on<LoadLds>(_onLoadLds);
  }

  Future<void> _onInitializeNewLd(
    InitializeNewLd event,
    Emitter<LdState> emit,
  ) async {
    // emit(LdLoaded(
    //   ld: LdModel(), // Create empty LD model
    //   isNewLd: true,
    // ));
  }

  Future<void> _onLoadLd(
    LoadLd event,
    Emitter<LdState> emit,
  ) async {
    emit(LdLoading());
    try {
      if (event.id != null) {
        final ld = await repository.getLd(event.id!);
        emit(LdLoaded(ld: ld, isNewLd: false));
      } else {
        // Create new empty LD with default values
        // emit(LdLoaded(
        //   ld: LdModel(
        //     ngaylap: DateTime.now(),
        //     // Add other default values as needed
        //   ),
        //   isNewLd: true,
        // ));
      }
    } catch (e) {
      emit(LdError('Failed to load LD: ${e.toString()}'));
    }
  }

  Future<void> _onSaveLd(
    SaveLd event,
    Emitter<LdState> emit,
  ) async {
    emit(LdLoading());
    try {
      // Validate LD data before saving
      if (!_validateLd(event.ld)) {
        emit(const LdError('Please fill in all required fields'));
        return;
      }

      if (event.isNewLd) {
        await repository.createLd(event.ld);
        emit(LdSaved(event.ld, message: 'LD created successfully'));
      } else {
        await repository.updateLd(event.ld);
        emit(LdSaved(event.ld, message: 'LD updated successfully'));
      }
    } catch (e) {
      emit(LdError('Failed to save LD: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateLd(
    UpdateLd event,
    Emitter<LdState> emit,
  ) async {
    emit(LdLoading());
    try {
      // Validate LD data before updating
      if (!_validateLd(event.ld)) {
        emit(const LdError('Please fill in all required fields'));
        return;
      }

      await repository.updateLd(event.ld);
      emit(LdSaved(event.ld, message: 'LD updated successfully'));
    } catch (e) {
      emit(LdError('Failed to update LD: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteLd(
    DeleteLd event,
    Emitter<LdState> emit,
  ) async {
    emit(LdLoading());
    try {
      await repository.deleteLd(event.id);
      emit(LdDeleted(message: 'LD deleted successfully'));
    } catch (e) {
      emit(LdError('Failed to delete LD: ${e.toString()}'));
    }
  }

  Future<void> _onLoadLds(
    LoadLds event,
    Emitter<LdState> emit,
  ) async {
    emit(LdLoading());
    try {
      final response = await repository.getLds(
        page: event.page,
        limit: event.limit,
        filters: event.filters,
      );

      if (response.isSuccessful()) {
        emit(LdsLoaded(
          response: response,
          currentPage: event.page,
          pageSize: event.limit,
        ));
      } else {
        emit(LdError('Failed to load LDs: Server returned error'));
      }
    } catch (e) {
      emit(LdError('Failed to load LDs: ${e.toString()}'));
    }
  }

  bool _validateLd(LdModel ld) {
    // Add validation logic here
    return ld.maphieu?.isNotEmpty == true &&
        ld.hoten?.isNotEmpty == true &&
        // Add other required field validations
        true;
  }
}
