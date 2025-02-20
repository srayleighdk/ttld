part of 'hinh_thuc_dia_diem_bloc.dart';

sealed class HinhThucDiaDiemState {}

class HinhThucDiaDiemInitial extends HinhThucDiaDiemState {}

class HinhThucDiaDiemLoading extends HinhThucDiaDiemState {}

class HinhThucDiaDiemLoaded extends HinhThucDiaDiemState {
  final List<HinhThucDiaDiem> hinhThucDiaDiems;

  HinhThucDiaDiemLoaded({required this.hinhThucDiaDiems});
}

class HinhThucDiaDiemError extends HinhThucDiaDiemState {
  final String message;

  HinhThucDiaDiemError({required this.message});
}
