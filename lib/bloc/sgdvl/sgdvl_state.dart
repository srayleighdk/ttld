part of 'sgdvl_bloc.dart';

abstract class SGDVLState {
  const SGDVLState();
}

class SGDVLInitial extends SGDVLState {
  const SGDVLInitial();
}

class SGDVLLoading extends SGDVLState {
  const SGDVLLoading();
}

class SGDVLLoaded extends SGDVLState {
  final List<SGDVL> sgdvls;
  const SGDVLLoaded(this.sgdvls);
}

class SGDVLError extends SGDVLState {
  final String message;
  const SGDVLError(this.message);
}

