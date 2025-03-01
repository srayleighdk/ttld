part of 'doituong_bloc.dart';

abstract class DoiTuongState extends Equatable {
  const DoiTuongState();

  @override
  List<Object> get props => [];
}

class DoiTuongInitial extends DoiTuongState {}

class DoiTuongLoading extends DoiTuongState {}

class DoiTuongLoaded extends DoiTuongState {
  final List<DoiTuong> doiTuongs;

  const DoiTuongLoaded(this.doiTuongs);

  @override
  List<Object> get props => [doiTuongs];
}

class DoiTuongError extends DoiTuongState {
  final String message;

  const DoiTuongError(this.message);

  @override
  List<Object> get props => [message];
}

class DoiTuongOperationSuccess extends DoiTuongState {}

class DoiTuongOperationFailure extends DoiTuongState {
  final String message;

  const DoiTuongOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}
