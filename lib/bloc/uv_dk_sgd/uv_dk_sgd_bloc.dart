import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/uv_dk_sgd/uv_dk_sgd_model.dart';
import 'package:ttld/repositories/uv_dk_sgd_repository.dart';

part 'uv_dk_sgd_event.dart';
part 'uv_dk_sgd_state.dart';

class UvDkSGDBloc extends Bloc<UvDkSGDEvent, UvDkSGDState> {
  final UvDkSGDRepository _repository;

  UvDkSGDBloc(this._repository) : super(UvDkSGDInitial()) {
    on<FetchUvDkSGDs>(_onFetchUvDkSGDs);
  }

  Future<void> _onFetchUvDkSGDs(
    FetchUvDkSGDs event,
    Emitter<UvDkSGDState> emit,
  ) async {
    emit(UvDkSGDLoading());
    try {
      final uvDkSGDs = await _repository.getUvDkSGDs(event.userId);
      emit(UvDkSGDLoaded(uvDkSGDs));
    } catch (e) {
      emit(UvDkSGDError(e.toString()));
    }
  }
}
