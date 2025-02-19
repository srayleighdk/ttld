import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/tttantat/tttantat.dart';
import 'package:ttld/repositories/tblDmTTtantat/tantat_repository.dart';

part 'tantat_event.dart';
part 'tantat_state.dart';

class TinhTrangTanTatBloc
    extends Bloc<TinhTrangTanTatEvent, TinhTrangTanTatState> {
  final TinhTrangTanTatRepository tinhTrangTanTatRepository;

  TinhTrangTanTatBloc(this.tinhTrangTanTatRepository)
      : super(TinhTrangTanTatInitial()) {
    on<LoadTinhTrangTanTats>((event, emit) async {
      emit(TinhTrangTanTatLoading());
      try {
        final tinhTrangTanTats =
            await tinhTrangTanTatRepository.getTinhTrangTanTats();
        emit(TinhTrangTanTatLoaded(tinhTrangTanTats));
      } catch (e) {
        emit(TinhTrangTanTatError('Failed to load tình trạng tàn tật: $e'));
      }
    });

    on<CreateTinhTrangTanTat>((event, emit) async {
      try {
        await tinhTrangTanTatRepository
            .createTinhTrangTanTat(event.tinhTrangTanTat);
        emit(TinhTrangTanTatOperationSuccess());
        add(LoadTinhTrangTanTats());
      } catch (e) {
        emit(TinhTrangTanTatOperationFailure(
            'Failed to create tình trạng tàn tật: $e'));
      }
    });

    on<UpdateTinhTrangTanTat>((event, emit) async {
      try {
        await tinhTrangTanTatRepository.updateTinhTrangTanTat(
            event.id, event.tinhTrangTanTat);
        emit(TinhTrangTanTatOperationSuccess());
        add(LoadTinhTrangTanTats());
      } catch (e) {
        emit(TinhTrangTanTatOperationFailure(
            'Failed to update tình trạng tàn tật: $e'));
      }
    });

    on<DeleteTinhTrangTanTat>((event, emit) async {
      try {
        await tinhTrangTanTatRepository.deleteTinhTrangTanTat(event.id);
        emit(TinhTrangTanTatOperationSuccess());
        add(LoadTinhTrangTanTats());
      } catch (e) {
        emit(TinhTrangTanTatOperationFailure(
            'Failed to delete tình trạng tàn tật: $e'));
      }
    });
  }
}
