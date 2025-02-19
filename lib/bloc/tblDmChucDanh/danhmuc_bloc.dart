import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttld/models/danhmuc/danhmuc.dart';
import 'package:ttld/repositories/tblDmChucDanh/danhmuc_repository.dart';

part 'danhmuc_event.dart';
part 'danhmuc_state.dart';

class DanhMucBloc extends Bloc<DanhMucEvent, DanhMucState> {
  final DanhMucRepository danhMucRepository; // Inject the repository

  DanhMucBloc(this.danhMucRepository) : super(DanhMucInitial()) {
    on<LoadDanhMucs>((event, emit) async {
      emit(DanhMucLoading());
      try {
        final danhmucs =
            await danhMucRepository.getDanhMucs(); // Use the repository
        emit(DanhMucLoaded(danhmucs));
      } catch (e) {
        emit(DanhMucError('Failed to load danh mục: $e'));
      }
    });

    on<CreateDanhMuc>((event, emit) async {
      try {
        await danhMucRepository
            .createDanhMuc(event.danhmuc); // Use the repository
        emit(DanhMucOperationSuccess());
        add(LoadDanhMucs());
      } catch (e) {
        emit(DanhMucOperationFailure('Failed to create danh mục: $e'));
      }
    });

    on<UpdateDanhMuc>((event, emit) async {
      try {
        await danhMucRepository.updateDanhMuc(
            event.id, event.danhmuc); // Use the repository
        emit(DanhMucOperationSuccess());
        add(LoadDanhMucs());
      } catch (e) {
        emit(DanhMucOperationFailure('Failed to update danh mục: $e'));
      }
    });

    on<DeleteDanhMuc>((event, emit) async {
      try {
        await danhMucRepository.deleteDanhMuc(event.id); // Use the repository
        emit(DanhMucOperationSuccess());
        add(LoadDanhMucs());
      } catch (e) {
        emit(DanhMucOperationFailure('Failed to delete danh mục: $e'));
      }
    });
  }
}
