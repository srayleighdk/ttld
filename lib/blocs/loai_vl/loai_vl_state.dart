part of 'loai_vl_bloc.dart';

sealed class LoaiVLState {}

class LoaiVLInitial extends LoaiVLState {}

class LoaiVLLoading extends LoaiVLState {}

class LoaiVLLoaded extends LoaiVLState {
  final List<LoaiViecLam> loaiVLs;

  LoaiVLLoaded({required this.loaiVLs});
}

class LoaiVLError extends LoaiVLState {
  final String message;

  LoaiVLError({required this.message});
}
