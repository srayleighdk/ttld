part of 'hosoungvien_bloc.dart';

@immutable
sealed class HoSoUngVienState {}

final class HoSoUngVienInitial extends HoSoUngVienState {}

final class HoSoUngVienLoading extends HoSoUngVienState {}

final class HoSoUngVienLoaded extends HoSoUngVienState {
  final List<TblHoSoUngVienModel> hoSoUngVienList;

  const HoSoUngVienLoaded(this.hoSoUngVienList);
}

final class HoSoUngVienError extends HoSoUngVienState {
  final String message;

  const HoSoUngVienError(this.message);
}
