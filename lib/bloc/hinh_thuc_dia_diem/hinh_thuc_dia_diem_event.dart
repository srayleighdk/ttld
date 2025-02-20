part of 'hinh_thuc_dia_diem_bloc.dart';

sealed class HinhThucDiaDiemEvent {}

class LoadHinhThucDiaDiems extends HinhThucDiaDiemEvent {}

class AddHinhThucDiaDiem extends HinhThucDiaDiemEvent {
  final HinhThucDiaDiem hinhThucDiaDiem;

  AddHinhThucDiaDiem({required this.hinhThucDiaDiem});
}

class UpdateHinhThucDiaDiem extends HinhThucDiaDiemEvent {
  final HinhThucDiaDiem hinhThucDiaDiem;

  UpdateHinhThucDiaDiem({required this.hinhThucDiaDiem});
}

class DeleteHinhThucDiaDiem extends HinhThucDiaDiemEvent {
  final int id;

  DeleteHinhThucDiaDiem({required this.id});
}
