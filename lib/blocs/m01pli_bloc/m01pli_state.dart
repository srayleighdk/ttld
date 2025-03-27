part of 'm01pli_bloc.dart';

@immutable
sealed class M01PliState {}

class M01PliInitial extends M01PliState {}

class M01PliLoading extends M01PliState {}

class M01PliLoadSuccess extends M01PliState {
  final List<M01Pli> plis;
  M01PliLoadSuccess(this.plis);
}

class M01PliCreateSuccess extends M01PliState {
  final M01Pli pli;
  M01PliCreateSuccess(this.pli);
}

class M01PliUpdateSuccess extends M01PliState {
  final M01Pli pli;
  M01PliUpdateSuccess(this.pli);
}

class M01PliDeleteSuccess extends M01PliState {}

class M01PliOperationFailure extends M01PliState {
  final String error;
  M01PliOperationFailure(this.error);
}
