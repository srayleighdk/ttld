import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_event.dart';
import 'package:ttld/blocs/tblHoSoUngVien/tblhosoungvien_state.dart';
import 'package:ttld/repositories/tblHoSoUngVien/ntv_repository.dart';

class NTVBloc extends Bloc<NTVEvent, NTVState> {
  final NTVRepository _ntvRepository;

  NTVBloc(this._ntvRepository) : super(NTVInitial()) {
    on<LoadTblHoSoUngViens>((event, emit) async {
      emit(NTVLoading());
      try {
        final tblHoSoUngViens = await _ntvRepository.getAllHoSoUngVien();
        emit(NTVLoaded(tblHoSoUngViens));
      } catch (e) {
        emit(NTVError(e.toString()));
      }
    });

    on<LoadTblHoSoUngViensByIdDn>((event, emit) async {
      emit(NTVLoading());
      try {
        final tblHoSoUngViens = await _ntvRepository.getHoSoUngVienByIdDn(event.idDn);
        emit(NTVLoaded(tblHoSoUngViens));
      } catch (e) {
        emit(NTVError(e.toString()));
      }
    });

    on<LoadTblHoSoUngVien>((event, emit) async {
      emit(NTVLoading());
      try {
        final tblHoSoUngVien =
            await _ntvRepository.getHoSoUngVienById(event.id);
        emit(NTVLoadedById(tblHoSoUngVien));
      } catch (e) {
        emit(NTVError(e.toString()));
      }
    });

    on<LoadTblHoSoUngVienByUvId>((event, emit) async {
      emit(NTVLoading());
      try {
        final tblHoSoUngVien =
            await _ntvRepository.getHoSoUngVienByUvId(event.uvId);
        emit(NTVLoadedById(tblHoSoUngVien));
      } catch (e) {
        emit(NTVError(e.toString()));
      }
    });

    on<AddTblHoSoUngVien>((event, emit) async {
      try {
        await _ntvRepository.createHoSoUngVien(event.tblHoSoUngVien);
        final tblHoSoUngViens = await _ntvRepository.getAllHoSoUngVien();
        emit(NTVLoaded(tblHoSoUngViens));
      } catch (e) {
        emit(NTVError(e.toString()));
      }
    });

    on<UpdateTblHoSoUngVien>((event, emit) async {
      try {
        final response =
            await _ntvRepository.updateHoSoUngVien(event.id, event.formData);
        emit(NTVUpdated('Thông tin của bạn đã được cập nhật thành công'));
      } catch (e) {
        emit(NTVError(e.toString()));
      }
    });

    on<DeleteTblHoSoUngVien>((event, emit) async {
      try {
        await _ntvRepository.deleteHoSoUngVien(event.id.toString());
        final tblHoSoUngViens = await _ntvRepository.getAllHoSoUngVien();
        emit(NTVLoaded(tblHoSoUngViens));
      } catch (e) {
        emit(NTVError(e.toString()));
      }
    });
  }
}
