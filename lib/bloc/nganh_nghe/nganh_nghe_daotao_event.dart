part of 'nganh_nghe_daotao_bloc.dart';

sealed class NganhNgheDaoTaoEvent {}

class LoadNganhNgheDaoTaos extends NganhNgheDaoTaoEvent {}

class AddNganhNgheDaoTao extends NganhNgheDaoTaoEvent {
  final NganhNgheDaoTao nganhNgheDaoTao;

  AddNganhNgheDaoTao({required this.nganhNgheDaoTao});
}

class UpdateNganhNgheDaoTao extends NganhNgheDaoTaoEvent {
  final NganhNgheDaoTao nganhNgheDaoTao;

  UpdateNganhNgheDaoTao({required this.nganhNgheDaoTao});
}

class DeleteNganhNgheDaoTao extends NganhNgheDaoTaoEvent {
  final String nnTen;

  DeleteNganhNgheDaoTao({required this.nnTen});
}
