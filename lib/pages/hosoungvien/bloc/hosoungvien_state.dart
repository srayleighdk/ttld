part of 'hosoungvien_bloc.dart';

@immutable
sealed class HoSoUngVienState {
  const HoSoUngVienState({
    this.page = 1,
  });

  final int page;
}

final class HoSoUngVienInitial extends HoSoUngVienState {}

final class HoSoUngVienLoading extends HoSoUngVienState {}

final class HoSoUngVienLoaded extends HoSoUngVienState {
  final List<TblHoSoUngVienModel> hoSoUngVienList;
  @override
  final int page;

  const HoSoUngVienLoaded(this.hoSoUngVienList, {required this.page});
}

final class HoSoUngVienError extends HoSoUngVienState {
  final String message;

  const HoSoUngVienError(this.message);
}
