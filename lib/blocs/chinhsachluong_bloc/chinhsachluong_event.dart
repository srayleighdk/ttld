part of 'chinhsachluong_bloc.dart';

@immutable
sealed class ChinhSachLuongEvent {}

class LoadChinhSachLuongs extends ChinhSachLuongEvent {}

class CreateChinhSachLuong extends ChinhSachLuongEvent {
  final ChinhSachLuong csl;
  CreateChinhSachLuong(this.csl);
}

class UpdateChinhSachLuong extends ChinhSachLuongEvent {
  final ChinhSachLuong csl;
  UpdateChinhSachLuong(this.csl);
}

class DeleteChinhSachLuong extends ChinhSachLuongEvent {
  final int id;
  DeleteChinhSachLuong(this.id);
}
