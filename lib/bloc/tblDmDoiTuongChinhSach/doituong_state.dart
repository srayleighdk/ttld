part of 'doituong_bloc.dart';

abstract class DoiTuongChinhSachState extends Equatable {
  const DoiTuongChinhSachState();

  @override
  List<Object> get props => [];
}

class DoiTuongChinhSachInitial extends DoiTuongChinhSachState {}

class DoiTuongChinhSachLoading extends DoiTuongChinhSachState {}

class DoiTuongChinhSachLoaded extends DoiTuongChinhSachState {
  final List<DoiTuongChinhSach> doiTuongChinhSachs;

  const DoiTuongChinhSachLoaded(this.doiTuongChinhSachs);

  @override
  List<Object> get props => [doiTuongChinhSachs];
}

class DoiTuongChinhSachError extends DoiTuongChinhSachState {
  final String message;

  const DoiTuongChinhSachError(this.message);

  @override
  List<Object> get props => [message];
}

class DoiTuongChinhSachOperationSuccess extends DoiTuongChinhSachState {}

class DoiTuongChinhSachOperationFailure extends DoiTuongChinhSachState {
  final String message;

  const DoiTuongChinhSachOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}
