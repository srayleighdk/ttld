part of 'hinh_thuc_dao_tao_bloc.dart';

sealed class HinhThucDaoTaoState {}

class HinhThucDaoTaoInitial extends HinhThucDaoTaoState {}

class HinhThucDaoTaoLoading extends HinhThucDaoTaoState {}

class HinhThucDaoTaoLoaded extends HinhThucDaoTaoState {
  final List<HinhThucDaoTao> hinhThucDaoTaos;

  HinhThucDaoTaoLoaded({required this.hinhThucDaoTaos});
}

class HinhThucDaoTaoError extends HinhThucDaoTaoState {
  final String message;

  HinhThucDaoTaoError({required this.message});
}
