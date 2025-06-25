part of 'hinh_thuc_loai_hinh_bloc.dart';

sealed class HinhThucLoaiHinhEvent {}

class LoadHinhThucLoaiHinhs extends HinhThucLoaiHinhEvent {}

class AddHinhThucLoaiHinh extends HinhThucLoaiHinhEvent {
  final HinhThucLoaiHinh hinhThucLoaiHinh;

  AddHinhThucLoaiHinh({required this.hinhThucLoaiHinh});
}

class UpdateHinhThucLoaiHinh extends HinhThucLoaiHinhEvent {
  final HinhThucLoaiHinh hinhThucLoaiHinh;

  UpdateHinhThucLoaiHinh({required this.hinhThucLoaiHinh});
}

class DeleteHinhThucLoaiHinh extends HinhThucLoaiHinhEvent {
  final String idLhdn;

  DeleteHinhThucLoaiHinh({required this.idLhdn});
}
