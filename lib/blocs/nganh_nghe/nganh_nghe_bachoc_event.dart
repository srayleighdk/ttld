part of 'nganh_nghe_bachoc_bloc.dart';

sealed class NganhNgheBacHocEvent {}

class LoadNganhNgheBacHocs extends NganhNgheBacHocEvent {}

class AddNganhNgheBacHoc extends NganhNgheBacHocEvent {
  final TrinhDoChuyenMon nganhNgheBacHoc;

  AddNganhNgheBacHoc({required this.nganhNgheBacHoc});
}

class UpdateNganhNgheBacHoc extends NganhNgheBacHocEvent {
  final TrinhDoChuyenMon nganhNgheBacHoc;

  UpdateNganhNgheBacHoc({required this.nganhNgheBacHoc});
}

class DeleteNganhNgheBacHoc extends NganhNgheBacHocEvent {
  final String id;

  DeleteNganhNgheBacHoc({required this.id});
}
