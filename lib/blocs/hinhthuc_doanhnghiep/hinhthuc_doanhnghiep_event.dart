part of 'hinhthuc_doanhnghiep_bloc.dart';

sealed class HinhThucDoanhNghiepEvent {}

class LoadHinhThucDoanhNghieps extends HinhThucDoanhNghiepEvent {}

class AddHinhThucDoanhNghiep extends HinhThucDoanhNghiepEvent {
  final HinhThucDoanhNghiep hinhThucDoanhNghiep;

  AddHinhThucDoanhNghiep({required this.hinhThucDoanhNghiep});
}

class UpdateHinhThucDoanhNghiep extends HinhThucDoanhNghiepEvent {
  final HinhThucDoanhNghiep hinhThucDoanhNghiep;

  UpdateHinhThucDoanhNghiep({required this.hinhThucDoanhNghiep});
}

class DeleteHinhThucDoanhNghiep extends HinhThucDoanhNghiepEvent {
  final String idLhdn;

  DeleteHinhThucDoanhNghiep({required this.idLhdn});
}
