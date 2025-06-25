part of 'chuyenmon_bloc.dart';

abstract class ChuyenMonState extends Equatable {
  const ChuyenMonState();

  @override
  List<Object> get props => [];
}

class ChuyenMonInitial extends ChuyenMonState {}

class ChuyenMonLoading extends ChuyenMonState {}

class ChuyenMonLoaded extends ChuyenMonState {
  final List<ChuyenMon> chuyenMons;

  const ChuyenMonLoaded(this.chuyenMons);

  @override
  List<Object> get props => [chuyenMons];
}

class ChuyenMonError extends ChuyenMonState {
  final String message;

  const ChuyenMonError(this.message);

  @override
  List<Object> get props => [message];
}

class ChuyenMonOperationSuccess extends ChuyenMonState {}

class ChuyenMonOperationFailure extends ChuyenMonState {
  final String message;

  const ChuyenMonOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}
