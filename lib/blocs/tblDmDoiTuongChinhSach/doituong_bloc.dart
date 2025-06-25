import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/doituong_chinhsach/doituong.dart';
import 'package:ttld/repositories/tblDmDoiTuongChinhSach/doituong_repository.dart';

part 'doituong_event.dart';
part 'doituong_state.dart';

class DoiTuongBloc extends Bloc<DoiTuongEvent, DoiTuongState> {
  final DoiTuongRepository doiTuongRepository;

  DoiTuongBloc(this.doiTuongRepository) : super(DoiTuongInitial()) {
    on<LoadDoiTuongs>((event, emit) async {
      emit(DoiTuongLoading());
      try {
        final doiTuongs = await doiTuongRepository.getDoiTuongs();
        emit(DoiTuongLoaded(doiTuongs));
      } catch (e) {
        emit(DoiTuongError('Failed to load đối tượng chính sách: $e'));
      }
    });

    on<CreateDoiTuong>((event, emit) async {
      try {
        await doiTuongRepository.createDoiTuong(event.doiTuong);
        emit(DoiTuongOperationSuccess());
        add(LoadDoiTuongs());
      } catch (e) {
        emit(DoiTuongOperationFailure(
            'Failed to create đối tượng chính sách: $e'));
      }
    });

    on<UpdateDoiTuong>((event, emit) async {
      try {
        await doiTuongRepository.updateDoiTuong(event.id.toString(), event.doiTuong);
        emit(DoiTuongOperationSuccess());
        add(LoadDoiTuongs());
      } catch (e) {
        emit(DoiTuongOperationFailure(
            'Failed to update đối tượng chính sách: $e'));
      }
    });

    on<DeleteDoiTuong>((event, emit) async {
      try {
        await doiTuongRepository.deleteDoiTuong(event.id.toString());
        emit(DoiTuongOperationSuccess());
        add(LoadDoiTuongs());
      } catch (e) {
        emit(DoiTuongOperationFailure(
            'Failed to delete đối tượng chính sách: $e'));
      }
    });
  }
}
