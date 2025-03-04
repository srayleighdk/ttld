import 'package:ttld/models/m03pli_model.dart';

abstract class M03PLIState {}

class M03PLIInitial extends M03PLIState {}

class M03PLILoading extends M03PLIState {}

class M03PLILoaded extends M03PLIState {
  final List<M03PLIModel> m03plis;

  M03PLILoaded(this.m03plis);
}

class M03PLIError extends M03PLIState {
  final String message;

  M03PLIError(this.message);
}
