part of 'loai_vl_bloc.dart';

sealed class LoaiVLEvent {}

class LoadLoaiVLs extends LoaiVLEvent {}

class AddLoaiVL extends LoaiVLEvent {
  final LoaiViecLam loaiVL;

  AddLoaiVL({required this.loaiVL});
}

class UpdateLoaiVL extends LoaiVLEvent {
  final LoaiViecLam loaiVL;

  UpdateLoaiVL({required this.loaiVL});
}

class DeleteLoaiVL extends LoaiVLEvent {
  final String loaivieclamTen;

  DeleteLoaiVL({required this.loaivieclamTen});
}
