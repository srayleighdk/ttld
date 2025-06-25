part of 'thoigianlamviec_bloc.dart';

sealed class ThoiGianLamViecState {}

class ThoiGianLamViecInitial extends ThoiGianLamViecState {}

class ThoiGianLamViecLoading extends ThoiGianLamViecState {}

class ThoiGianLamViecLoaded extends ThoiGianLamViecState {
  final List<ThoiGianLamViec> thoiGianLamViecs;

  ThoiGianLamViecLoaded({required this.thoiGianLamViecs});
}

class ThoiGianLamViecError extends ThoiGianLamViecState {
  final String message;

  ThoiGianLamViecError({required this.message});
}
