part of 'hosoungvien_bloc.dart';

@immutable
sealed class HoSoUngVienEvent {}

class HoSoUngVienFetchData extends HoSoUngVienEvent {}

class HoSoUngVienDelete extends HoSoUngVienEvent {
  final int id;

  HoSoUngVienDelete(this.id);
}
