import 'package:bloc/bloc.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_event.dart';
import 'package:ttld/bloc/tblHoSoUngVien/tblHoSoUngVien_state.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';
import 'package:ttld/repositories/ntv_repository.dart';

class TblHoSoUngVienBloc extends Bloc<TblHoSoUngVienEvent, TblHoSoUngVienState> {
  final NtvRepository _ntvRepository;

  TblHoSoUngVienBloc(this._ntvRepository) : super(TblHoSoUngVienInitial()) {
    on<LoadTblHoSoUngViens>((event, emit) async {
      emit(TblHoSoUngVienLoading());
      try {
        final tblHoSoUngViens = await _ntvRepository.getAllHoSoUngVien();
        emit(TblHoSoUngVienLoaded(tblHoSoUngViens));
      } catch (e) {
        emit(TblHoSoUngVienError(e.toString()));
      }
    });

    on<LoadTblHoSoUngVien>((event, emit) async {
      emit(TblHoSoUngVienLoading());
      try {
        final tblHoSoUngVien = await _ntvRepository.getHoSoUngVienById(event.id);
        emit(TblHoSoUngVienLoadedById(tblHoSoUngVien));
      } catch (e) {
        emit(TblHoSoUngVienError(e.toString()));
      }
    });

    on<AddTblHoSoUngVien>((event, emit) async {
      try {
        await _ntvRepository.createHoSoUngVien(event.tblHoSoUngVien);
        final tblHoSoUngViens = await _ntvRepository.getAllHoSoUngVien();
        emit(TblHoSoUngVienLoaded(tblHoSoUngViens));
      } catch (e) {
        emit(TblHoSoUngVienError(e.toString()));
      }
    });

    on<UpdateTblHoSoUngVien>((event, emit) async {
      try {
        await _ntvRepository.updateHoSoUngVien(event.tblHoSoUngVien.idHoSo!, event.tblHoSoUngVien);
        final tblHoSoUngViens = await _ntvRepository.getAllHoSoUngVien();
        emit(TblHoSoUngVienLoaded(tblHoSoUngViens));
      } catch (e) {
        emit(TblHoSoUngVienError(e.toString()));
      }
    });

    on<DeleteTblHoSoUngVien>((event, emit) async {
      try {
        await _ntvRepository.deleteHoSoUngVien(event.id.toString());
        final tblHoSoUngViens = await _ntvRepository.getAllHoSoUngVien();
        emit(TblHoSoUngVienLoaded(tblHoSoUngViens));
      } catch (e) {
        emit(TblHoSoUngVienError(e.toString()));
      }
    });
  }
}
