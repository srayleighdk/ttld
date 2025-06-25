part of 'vieclam_ungvien_bloc.dart';

@immutable
sealed class ViecLamUngVienState {}

final class ViecLamUngVienInitial extends ViecLamUngVienState {}

final class ViecLamUngVienLoading extends ViecLamUngVienState {}

final class ViecLamUngVienLoaded extends ViecLamUngVienState {
  final List<TblViecLamUngVienModel> viecLamUngVienList;

  ViecLamUngVienLoaded(this.viecLamUngVienList);
}

final class ViecLamUngVienError extends ViecLamUngVienState {
  final String message;

  ViecLamUngVienError(this.message);
}

