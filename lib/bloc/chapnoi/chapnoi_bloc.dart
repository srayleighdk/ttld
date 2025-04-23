import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/chapnoi/chapnoi_model.dart';
import '../../repositories/chapnoi_repository.dart';

part 'chapnoi_event.dart';
part 'chapnoi_state.dart';

class ChapNoiBloc extends Bloc<ChapNoiEvent, ChapNoiState> {
  final ChapNoiRepository _chapNoiRepository;

  ChapNoiBloc(this._chapNoiRepository) : super(ChapNoiInitial()) {
    on<ChapNoiFetchList>(_onFetchChapNoiList);
    on<ChapNoiCreate>(_onCreateChapNoi);
  }

  Future<void> _onFetchChapNoiList(
      ChapNoiFetchList event, Emitter<ChapNoiState> emit) async {
    emit(ChapNoiLoading());
    try {
      final response = await _chapNoiRepository.getChapNoiList(
        limit: event.limit,
        page: event.page,
        status: event.status,
        idTuyenDung: event.idTuyenDung,
        idDoanhNghiep: event.idDoanhNghiep,
      );
      emit(ChapNoiListLoaded(response.data ?? [], response.total ?? 0));
    } catch (e) {
      emit(ChapNoiError(e.toString()));
    }
  }

  Future<void> _onCreateChapNoi(
      ChapNoiCreate event, Emitter<ChapNoiState> emit) async {
    emit(ChapNoiLoading()); // Consider a specific 'ChapNoiCreating' state if needed
    try {
      final response = await _chapNoiRepository.createChapNoi(event.chapNoi);
       if (response.data != null) {
         emit(ChapNoiCreated(response.data!, response.message ?? 'Success'));
       } else {
         // Handle case where data is null but no exception was thrown (should ideally not happen with proper API design)
         emit(ChapNoiError(response.message ?? 'Failed to create ChapNoi: No data returned'));
       }
    } catch (e) {
      emit(ChapNoiError(e.toString()));
    }
  }
}
