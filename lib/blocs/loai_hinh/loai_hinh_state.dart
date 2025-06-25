part of 'loai_hinh_bloc.dart';

sealed class LoaiHinhState {}

class LoaiHinhInitial extends LoaiHinhState {}

class LoaiHinhLoading extends LoaiHinhState {}

class LoaiHinhLoaded extends LoaiHinhState {
  final List<LoaiHinh> loaiHinhs;

  LoaiHinhLoaded({required this.loaiHinhs});
}

class LoaiHinhError extends LoaiHinhState {
  final String message;

  LoaiHinhError({required this.message});
}
