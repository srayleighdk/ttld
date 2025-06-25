part of 'thoigianlamviec_bloc.dart';

sealed class ThoiGianLamViecEvent {}

class LoadThoiGianLamViecs extends ThoiGianLamViecEvent {}

class AddThoiGianLamViec extends ThoiGianLamViecEvent {
  final ThoiGianLamViec thoiGianLamViec;

  AddThoiGianLamViec({required this.thoiGianLamViec});
}

class UpdateThoiGianLamViec extends ThoiGianLamViecEvent {
  final ThoiGianLamViec thoiGianLamViec;

  UpdateThoiGianLamViec({required this.thoiGianLamViec});
}

class DeleteThoiGianLamViec extends ThoiGianLamViecEvent {
  final int id;

  DeleteThoiGianLamViec({required this.id});
}
