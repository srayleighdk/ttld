import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/doituong_chinhsach/doituong.dart';
import 'package:ttld/repositories/tblDmDoiTuongChinhSach/doituong_repository.dart';

part 'doituong_event.dart';
part 'doituong_state.dart';

class DoiTuongChinhSachBloc
    extends Bloc<DoiTuongChinhSachEvent, DoiTuongChinhSachState> {
  final DoiTuongChinhSachRepository doiTuongChinhSachRepository;

  DoiTuongChinhSachBloc(this.doiTuongChinhSachRepository)
      : super(DoiTuongChinhSachInitial()) {
    on<LoadDoiTuongChinhSachs>((event, emit) async {
      emit(DoiTuongChinhSachLoading());
      try {
        final doiTuongChinhSachs =
            await doiTuongChinhSachRepository.getDoiTuongChinhSachs();
        emit(DoiTuongChinhSachLoaded(doiTuongChinhSachs));
      } catch (e) {
        emit(DoiTuongChinhSachError('Failed to load đối tượng chính sách: $e'));
      }
    });

    on<CreateDoiTuongChinhSach>((event, emit) async {
      try {
        await doiTuongChinhSachRepository
            .createDoiTuongChinhSach(event.doiTuongChinhSach);
        emit(DoiTuongChinhSachOperationSuccess());
        add(LoadDoiTuongChinhSachs());
      } catch (e) {
        emit(DoiTuongChinhSachOperationFailure(
            'Failed to create đối tượng chính sách: $e'));
      }
    });

    on<UpdateDoiTuongChinhSach>((event, emit) async {
      try {
        await doiTuongChinhSachRepository.updateDoiTuongChinhSach(
            event.id, event.doiTuongChinhSach);
        emit(DoiTuongChinhSachOperationSuccess());
        add(LoadDoiTuongChinhSachs());
      } catch (e) {
        emit(DoiTuongChinhSachOperationFailure(
            'Failed to update đối tượng chính sách: $e'));
      }
    });

    on<DeleteDoiTuongChinhSach>((event, emit) async {
      try {
        await doiTuongChinhSachRepository.deleteDoiTuongChinhSach(event.id);
        emit(DoiTuongChinhSachOperationSuccess());
        add(LoadDoiTuongChinhSachs());
      } catch (e) {
        emit(DoiTuongChinhSachOperationFailure(
            'Failed to delete đối tượng chính sách: $e'));
      }
    });
  }
}
