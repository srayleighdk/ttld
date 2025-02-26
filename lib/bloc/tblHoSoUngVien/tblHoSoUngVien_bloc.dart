import 'package:bloc/bloc.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_event.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_state.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';
import 'package:ttld/repositories/tblViecLamUngVien/vieclam_ungvien_repository.dart';

class TblHoSoUngVienBloc extends Bloc<TblHoSoUngVienEvent, TblHoSoUngVienState> {
  final ViecLamUngVienRepository _tblHoSoUngVienRepository;

  TblHoSoUngVienBloc(this._tblHoSoUngVienRepository) : super(TblHoSoUngVienInitial()) {
    on<LoadTblHoSoUngViens>((event, emit) async {
      emit(TblHoSoUngVienLoading());
      try {
        final tblHoSoUngViens = await _tblHoSoUngVienRepository.getViecLamUngViens();
        emit(TblHoSoUngVienLoaded(tblHoSoUngViens));
      } catch (e) {
        emit(TblHoSoUngVienError(e.toString()));
      }
    });

    on<LoadTblHoSoUngVien>((event, emit) async {
      emit(TblHoSoUngVienLoading());
      try {
        final tblHoSoUngVien = await _tblHoSoUngVienRepository.getViecLamUngVien(event.id);
        emit(TblHoSoUngVienLoadedById(tblHoSoUngVien));
      } catch (e) {
        emit(TblHoSoUngVienError(e.toString()));
      }
    });

    on<AddTblHoSoUngVien>((event, emit) async {
      try {
        await _tblHoSoUngVienRepository.addViecLamUngVien(event.tblHoSoUngVien);
        final tblHoSoUngViens = await _tblHoSoUngVienRepository.getViecLamUngViens();
        emit(TblHoSoUngVienLoaded(tblHoSoUngViens));
      } catch (e) {
        emit(TblHoSoUngVienError(e.toString()));
      }
    });

    on<UpdateTblHoSoUngVien>((event, emit) async {
      try {
        await _tblHoSoUngVienRepository.updateViecLamUngVien(event.tblHoSoUngVien);
        final tblHoSoUngViens = await _tblHoSoUngVienRepository.getViecLamUngViens();
        emit(TblHoSoUngVienLoaded(tblHoSoUngViens));
      } catch (e) {
        emit(TblHoSoUngVienError(e.toString()));
      }
    });

    on<DeleteTblHoSoUngVien>((event, emit) async {
      try {
        await _tblHoSoUngVienRepository.deleteViecLamUngVien(event.id);
        final tblHoSoUngViens = await _tblHoSoUngVienRepository.getViecLamUngViens();
        emit(TblHoSoUngVienLoaded(tblHoSoUngViens));
      } catch (e) {
        emit(TblHoSoUngVienError(e.toString()));
      }
    });
  }
}
