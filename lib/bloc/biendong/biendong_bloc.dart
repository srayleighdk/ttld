import 'package:bloc/bloc.dart';
import 'package:ttld/models/biendong_model.dart';
import 'package:ttld/repositories/biendong_repository.dart';

part 'biendong_event.dart';
part 'biendong_state.dart';

class BienDongBloc extends Bloc<BienDongEvent, BienDongState> {
  final BienDongRepository _repository;

  BienDongBloc(this._repository) : super(BienDongInitial()) {
    on<FetchBienDongList>(_onFetchBienDongList);
    on<CreateBienDong>(_onCreateBienDong);
    on<UpdateBienDong>(_onUpdateBienDong);
    on<DeleteBienDong>(_onDeleteBienDong);
  }

  Future<void> _onFetchBienDongList(
    FetchBienDongList event,
    Emitter<BienDongState> emit,
  ) async {
    emit(BienDongLoading());
    try {
      final bienDongList = await _repository.getBienDongList(event.userId);
      emit(BienDongLoaded(bienDongList));
    } catch (e) {
      emit(BienDongError(e.toString()));
    }
  }

  Future<void> _onCreateBienDong(
    CreateBienDong event,
    Emitter<BienDongState> emit,
  ) async {
    emit(BienDongLoading());
    try {
      final newBienDong = await _repository.createBienDong(event.bienDong);
      final currentState = state as BienDongLoaded;
      emit(BienDongLoaded([...currentState.bienDongList, newBienDong]));
    } catch (e) {
      emit(BienDongError(e.toString()));
    }
  }

  Future<void> _onUpdateBienDong(
    UpdateBienDong event,
    Emitter<BienDongState> emit,
  ) async {
    emit(BienDongLoading());
    try {
      final updatedBienDong = await _repository.updateBienDong(event.bienDong);
      final currentState = state as BienDongLoaded;
      final newList = currentState.bienDongList.map((bd) =>
          bd.id == updatedBienDong.id ? updatedBienDong : bd
      ).toList();
      emit(BienDongLoaded(newList));
    } catch (e) {
      emit(BienDongError(e.toString()));
    }
  }

  Future<void> _onDeleteBienDong(
    DeleteBienDong event,
    Emitter<BienDongState> emit,
  ) async {
    emit(BienDongLoading());
    try {
      await _repository.deleteBienDong(event.id);
      final currentState = state as BienDongLoaded;
      final newList = currentState.bienDongList
          .where((bd) => bd.id != event.id)
          .toList();
      emit(BienDongLoaded(newList));
    } catch (e) {
      emit(BienDongError(e.toString()));
    }
  }
}
