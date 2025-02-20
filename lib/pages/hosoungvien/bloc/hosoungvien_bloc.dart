import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ttld/core/services/hosoungvien_api_service.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';

part 'hosoungvien_event.dart';
part 'hosoungvien_state.dart';

class HoSoUngVienBloc extends Bloc<HoSoUngVienEvent, HoSoUngVienState> {
  final HoSoUngVienApiService hoSoUngVienApiService;
  HoSoUngVienBloc({required this.hoSoUngVienApiService})
      : super(HoSoUngVienInitial()) {
    on<HoSoUngVienFetchData>((event, emit) async {
      emit(HoSoUngVienLoading());
      try {
        final hoSoUngVienList = await hoSoUngVienApiService.getHoSoUngVienList();
        emit(HoSoUngVienLoaded(hoSoUngVienList));
      } catch (e) {
        emit(HoSoUngVienError('Failed to fetch  $e'));
      }
    });

    on<HoSoUngVienDelete>((event, emit) async {
      // Implement delete logic here, if applicable
      // and emit appropriate state
    });
  }
}
