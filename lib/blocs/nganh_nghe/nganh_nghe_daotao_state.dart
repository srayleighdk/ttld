part of 'nganh_nghe_daotao_bloc.dart';

sealed class NganhNgheDaoTaoState {}

class NganhNgheDaoTaoInitial extends NganhNgheDaoTaoState {}

class NganhNgheDaoTaoLoading extends NganhNgheDaoTaoState {}

class NganhNgheDaoTaoLoaded extends NganhNgheDaoTaoState {
  final List<NganhNgheDaoTao> nganhNgheDaoTaos;

  NganhNgheDaoTaoLoaded({required this.nganhNgheDaoTaos});
}

class NganhNgheDaoTaoError extends NganhNgheDaoTaoState {
  final String message;

  NganhNgheDaoTaoError({required this.message});
}
