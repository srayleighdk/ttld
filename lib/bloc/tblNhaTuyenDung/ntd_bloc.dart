import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/tblNhaTuyenDung/tblNhaTuyenDung_model.dart';
import 'package:ttld/repositories/tblNhaTuyenDung/ntd_repository.dart';

part 'ntd_event.dart';
part 'ntd_state.dart';

class NTDBloc extends Bloc<NTDEvent, NTDState> {
  final NTDRepository _ntdRepository;

  NTDBloc(this._ntdRepository) : super(NTDInitial()) {
    on<NTDFetchList>((event, emit) async {
      emit(NTDLoading());
      try {
        final ntdList = await _ntdRepository.getNtdList();
        emit(NTDLoaded(ntdList));
      } catch (e) {
        emit(NTDError('Failed to fetch NTD list: $e'));
      }
    });

    on<NTDFetchById>((event, emit) async {
      emit(NTDLoading());
      try {
        final ntd = await _ntdRepository.getNtdById(event.id);
        emit(NTDLoadedById(ntd));
      } catch (e) {
        emit(NTDError('Failed to fetch NTD by ID: $e'));
      }
    });

    on<NTDAdd>((event, emit) async {
      emit(NTDLoading());
      try {
        await _ntdRepository.addNtd(event.ntd);
        final ntdList = await _ntdRepository.getNtdList();
        emit(NTDLoaded(ntdList));
      } catch (e) {
        emit(NTDError('Failed to add NTD: $e'));
      }
    });

    on<NTDUpdate>((event, emit) async {
      emit(NTDLoading());
      try {
        await _ntdRepository.updateNtd(event.ntd);
        emit(NTDSuccess('Cập nhật thành công'));
      } catch (e) {
        emit(NTDError('Failed to update NTD: $e'));
      }
    });

    on<NTDDelete>((event, emit) async {
      emit(NTDLoading());
      try {
        await _ntdRepository.deleteNtd(event.id);
        final ntdList = await _ntdRepository.getNtdList();
        emit(NTDLoaded(ntdList));
      } catch (e) {
        emit(NTDError('Failed to delete NTD: $e'));
      }
    });
  }
}
