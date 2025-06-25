part of 'sgdvl_bloc.dart';

abstract class SGDVLState {}

class SGDVLInitial extends SGDVLState {}

class SGDVLLoading extends SGDVLState {}

class SGDVLLoaded extends SGDVLState {
  final List<SGDVL> sgdvls;

  SGDVLLoaded(this.sgdvls);
}

class SGDVLError extends SGDVLState {
  final String message;

  SGDVLError(this.message);
}
