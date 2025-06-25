part of 'ntd_bloc.dart';

abstract class NTDState extends Equatable {
  const NTDState();

  @override
  List<Object> get props => [];
}

class NTDInitial extends NTDState {}

class NTDLoading extends NTDState {}

class NTDLoaded extends NTDState {
  final List<Ntd> ntdList;

  const NTDLoaded(this.ntdList);

  @override
  List<Object> get props => [ntdList];
}

class NTDLoadedById extends NTDState {
  final Ntd ntd;

  const NTDLoadedById(this.ntd);

  @override
  List<Object> get props => [ntd];
}

class NTDError extends NTDState {
  final String message;

  const NTDError(this.message);

  @override
  List<Object> get props => [message];
}

class NTDSuccess extends NTDState {
  final String message;

  const NTDSuccess(this.message);

  @override
  List<Object> get props => [message];
}
