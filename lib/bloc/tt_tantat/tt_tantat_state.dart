part of 'tt_tantat_bloc.dart';

abstract class TTTanTatState extends Equatable {
  const TTTanTatState();

  @override
  List<Object> get props => [];
}

class TTTanTatInitial extends TTTanTatState {}

class TTTanTatLoading extends TTTanTatState {}

class TTTanTatLoaded extends TTTanTatState {
  final List<TTTanTat> ttTanTats;

  const TTTanTatLoaded({required this.ttTanTats});

  @override
  List<Object> get props => [ttTanTats];
}

class TTTanTatError extends TTTanTatState {
  final String message;

  const TTTanTatError({required this.message});

  @override
  List<Object> get props => [message];
}
