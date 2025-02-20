part of 'nganh_nghe_chuyennganh_bloc.dart';

sealed class NganhNgheChuyenNganhEvent {}

class LoadNganhNgheChuyenNganhs extends NganhNgheChuyenNganhEvent {}

class AddNganhNgheChuyenNganh extends NganhNgheChuyenNganhEvent {
  final NganhNgheChuyenNganh nganhNgheChuyenNganh;

  AddNganhNgheChuyenNganh({required this.nganhNgheChuyenNganh});
}

class UpdateNganhNgheChuyenNganh extends NganhNgheChuyenNganhEvent {
  final NganhNgheChuyenNganh nganhNgheChuyenNganh;

  UpdateNganhNgheChuyenNganh({required this.nganhNgheChuyenNganh});
}

class DeleteNganhNgheChuyenNganh extends NganhNgheChuyenNganhEvent {
  final int ma;

  DeleteNganhNgheChuyenNganh({required this.ma});
}
