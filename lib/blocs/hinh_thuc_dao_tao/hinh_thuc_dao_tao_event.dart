part of 'hinh_thuc_dao_tao_bloc.dart';

sealed class HinhThucDaoTaoEvent {}

class LoadHinhThucDaoTaos extends HinhThucDaoTaoEvent {}

class AddHinhThucDaoTao extends HinhThucDaoTaoEvent {
  final HinhThucDaoTao hinhThucDaoTao;

  AddHinhThucDaoTao({required this.hinhThucDaoTao});
}

class UpdateHinhThucDaoTao extends HinhThucDaoTaoEvent {
  final HinhThucDaoTao hinhThucDaoTao;

  UpdateHinhThucDaoTao({required this.hinhThucDaoTao});
}

class DeleteHinhThucDaoTao extends HinhThucDaoTaoEvent {
  final String htdtTen;

  DeleteHinhThucDaoTao({required this.htdtTen});
}
