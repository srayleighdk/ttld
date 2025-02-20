part of 'hinhthuc_doanhnghiep_bloc.dart';

sealed class HinhThucDoanhNghiepState {}

class HinhThucDoanhNghiepInitial extends HinhThucDoanhNghiepState {}

class HinhThucDoanhNghiepLoading extends HinhThucDoanhNghiepState {}

class HinhThucDoanhNghiepLoaded extends HinhThucDoanhNghiepState {
  final List<HinhThucDoanhNghiep> hinhThucDoanhNghieps;

  HinhThucDoanhNghiepLoaded({required this.hinhThucDoanhNghieps});
}

class HinhThucDoanhNghiepError extends HinhThucDoanhNghiepState {
  final String message;

  HinhThucDoanhNghiepError({required this.message});
}
