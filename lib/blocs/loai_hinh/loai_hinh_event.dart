part of 'loai_hinh_bloc.dart';

sealed class LoaiHinhEvent {}

class LoadLoaiHinhs extends LoaiHinhEvent {}

class AddLoaiHinh extends LoaiHinhEvent {
  final LoaiHinh loaiHinh;

  AddLoaiHinh({required this.loaiHinh});
}

class UpdateLoaiHinh extends LoaiHinhEvent {
  final LoaiHinh loaiHinh;

  UpdateLoaiHinh({required this.loaiHinh});
}

class DeleteLoaiHinh extends LoaiHinhEvent {
  final String id;

  DeleteLoaiHinh({required this.id});
}
