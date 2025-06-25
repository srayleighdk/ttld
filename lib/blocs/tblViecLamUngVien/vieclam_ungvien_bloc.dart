import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ttld/models/tblViecLamUngVien/vieclam_ungvien_model.dart';
import 'package:ttld/repositories/tblViecLamUngVien/vieclam_ungvien_repository.dart';

part 'vieclam_ungvien_event.dart';
part 'vieclam_ungvien_state.dart';

class ViecLamUngVienBloc
    extends Bloc<ViecLamUngVienEvent, ViecLamUngVienState> {
  final ViecLamUngVienRepository viecLamUngVienRepository;

  ViecLamUngVienBloc({required this.viecLamUngVienRepository})
      : super(ViecLamUngVienInitial()) {
    on<ViecLamUngVienFetchData>((event, emit) async {
      emit(ViecLamUngVienLoading());
      try {
        final viecLamUngVienList =
            await viecLamUngVienRepository.getViecLamUngVienList();
        emit(ViecLamUngVienLoaded(viecLamUngVienList));
      } catch (e) {
        emit(ViecLamUngVienError('Failed to fetch ViecLamUngVien: $e'));
      }
    });
  }
}
