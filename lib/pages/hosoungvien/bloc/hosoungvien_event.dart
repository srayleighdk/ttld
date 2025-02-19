part of 'hosoungvien_bloc.dart';

@immutable
sealed class HoSoUngVienEvent {}

class HoSoUngVienFetchData extends HoSoUngVienEvent {
  final int page;
  HoSoUngVienFetchData({required this.page});
}

class HoSoUngVienDelete extends HoSoUngVienEvent {
  final int id;
  HoSoUngVienDelete(this.id);
}
