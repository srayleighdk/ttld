part of 'tinh_trangvl_bloc.dart';

sealed class TinhTrangVLState {}

class TinhTrangVLInitial extends TinhTrangVLState {}

class TinhTrangVLLoading extends TinhTrangVLState {}

class TinhTrangVLLoaded extends TinhTrangVLState {
  final List<TinhTrangViecLam> tinhTrangVLs;

  TinhTrangVLLoaded({required this.tinhTrangVLs});
}

class TinhTrangVLError extends TinhTrangVLState {
  final String message;

  TinhTrangVLError({required this.message});
}
