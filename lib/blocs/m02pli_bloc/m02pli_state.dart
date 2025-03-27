part of 'm02pli_bloc.dart';

@immutable
sealed class M02PliState {}

class M02PliInitial extends M02PliState {}

class M02PliLoading extends M02PliState {}

class M02PliLoadSuccess extends M02PliState {
  final List<M02Pli> plis;
  M02PliLoadSuccess(this.plis);
}

class M02PliCreateSuccess extends M02PliState {
  final M02Pli pli;
  M02PliCreateSuccess(this.pli);
}

class M02PliUpdateSuccess extends M02PliState {
  final M02Pli pli;
  M02PliUpdateSuccess(this.pli);
}

class M02PliDeleteSuccess extends M02PliState {}

class M02PliOperationFailure extends M02PliState {
  final String error;
  M02PliOperationFailure(this.error);
}
