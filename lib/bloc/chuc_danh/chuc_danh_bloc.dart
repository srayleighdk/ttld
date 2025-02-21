import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/bloc/chuc_danh/chuc_danh_event.dart';
import 'package:ttld/bloc/chuc_danh/chuc_danh_state.dart';
import 'package:ttld/repositories/chuc_danh_repository.dart';

class ChucDanhBloc extends Bloc<ChucDanhEvent, ChucDanhState> {
  ChucDanhBloc() : super(const ChucDanhInitial()) {
    final ChucDanhRepository chucDanhRepository = ChucDanhRepository();

    on<LoadChucDanhs>((event, emit) async {
      emit(const ChucDanhLoading());
      try {
        final chucDanhs = await chucDanhRepository.getChucDanhs();
        emit(ChucDanhLoaded(chucDanhs));
      } catch (e) {
        emit(ChucDanhError(e.toString()));
      }
    });
  }
}
