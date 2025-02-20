part of 'hinh_thuc_loai_hinh_bloc.dart';

sealed class HinhThucLoaiHinhState {}

class HinhThucLoaiHinhInitial extends HinhThucLoaiHinhState {}

class HinhThucLoaiHinhLoading extends HinhThucLoaiHinhState {}

class HinhThucLoaiHinhLoaded extends HinhThucLoaiHinhState {
  final List<HinhThucLoaiHinh> hinhThucLoaiHinhs;

  HinhThucLoaiHinhLoaded({required this.hinhThucLoaiHinhs});
}

class HinhThucLoaiHinhError extends HinhThucLoaiHinhState {
  final String message;

  HinhThucLoaiHinhError({required this.message});
}
