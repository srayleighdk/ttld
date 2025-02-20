part of 'tinh_trangvl_bloc.dart';

sealed class TinhTrangVLEvent {}

class LoadTinhTrangVLs extends TinhTrangVLEvent {}

class AddTinhTrangVL extends TinhTrangVLEvent {
  final TinhTrangViecLam tinhTrangVL;

  AddTinhTrangVL({required this.tinhTrangVL});
}

class UpdateTinhTrangVL extends TinhTrangVLEvent {
  final TinhTrangViecLam tinhTrangVL;

  UpdateTinhTrangVL({required this.tinhTrangVL});
}

class DeleteTinhTrangVL extends TinhTrangVLEvent {
  final String tenTrangThai;

  DeleteTinhTrangVL({required this.tenTrangThai});
}
