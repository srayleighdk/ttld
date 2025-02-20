part of 'kcn_cubit.dart';

sealed class KcnState {}

final class KcnInitial extends KcnState {}

final class KcnLoading extends KcnState {}

final class KcnLoaded extends KcnState {
  final dynamic data;

  KcnLoaded(this.data);
}

final class KcnError extends KcnState {
  final String message;

  KcnError(this.message);
}
