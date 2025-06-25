import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/sgdvl/sgdvl_model.dart';
import 'package:ttld/repositories/sgdvl_repository.dart';

part 'sgdvl_event.dart';
part 'sgdvl_state.dart';

class SGDVLBloc extends Bloc<SGDVLEvent, SGDVLState> {
  final SGDVLRepository _repository;

  SGDVLBloc(this._repository) : super(SGDVLInitial()) {
    on<LoadSGDVLs>(_onLoadSGDVLs);
  }

  Future<void> _onLoadSGDVLs(
    LoadSGDVLs event,
    Emitter<SGDVLState> emit,
  ) async {
    emit(SGDVLLoading());
    try {
      final sgdvls = await _repository.getSGDVLs();
      emit(SGDVLLoaded(sgdvls));
    } catch (e) {
      emit(SGDVLError(e.toString()));
    }
  }
}
