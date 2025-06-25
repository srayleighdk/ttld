part of 'ton_giao_bloc.dart';

sealed class TonGiaoState {}

class TonGiaoInitial extends TonGiaoState {}

class TonGiaoLoading extends TonGiaoState {}

class TonGiaoLoaded extends TonGiaoState {
  final List<TonGiao> tonGiaos;

  TonGiaoLoaded({required this.tonGiaos});
}

class TonGiaoError extends TonGiaoState {
  final String message;

  TonGiaoError({required this.message});
}
