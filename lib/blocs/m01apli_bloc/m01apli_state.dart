part of 'm01apli_bloc.dart';

@immutable
sealed class M01APliState {}

class M01APliInitial extends M01APliState {}

class M01APliLoading extends M01APliState {}

class M01APliLoadSuccess extends M01APliState {
  final List<M01APli> plis;
  M01APliLoadSuccess(this.plis);
}

class M01APliCreateSuccess extends M01APliState {
  final M01APli pli;
  M01APliCreateSuccess(this.pli);
}

class M01APliUpdateSuccess extends M01APliState {
  final M01APli pli;
  M01APliUpdateSuccess(this.pli);
}

class M01APliDeleteSuccess extends M01APliState {}

class M01APliOperationFailure extends M01APliState {
  final String error;
  M01APliOperationFailure(this.error);
}
