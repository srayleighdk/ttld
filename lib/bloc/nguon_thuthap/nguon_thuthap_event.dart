part of 'nguon_thuthap_bloc.dart';

sealed class NguonThuThapEvent {}

class LoadNguonThuThaps extends NguonThuThapEvent {}

class AddNguonThuThap extends NguonThuThapEvent {
  final NguonThuThap nguonThuThap;

  AddNguonThuThap({required this.nguonThuThap});
}

class UpdateNguonThuThap extends NguonThuThapEvent {
  final NguonThuThap nguonThuThap;

  UpdateNguonThuThap({required this.nguonThuThap});
}

class DeleteNguonThuThap extends NguonThuThapEvent {
  final String idNguonThuThap;

  DeleteNguonThuThap({required this.idNguonThuThap});
}
