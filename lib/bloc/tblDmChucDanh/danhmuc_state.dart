part of 'danhmuc_bloc.dart';

abstract class DanhMucState extends Equatable {
  const DanhMucState();

  @override
  List<Object> get props => [];
}

class DanhMucInitial extends DanhMucState {}

class DanhMucLoading extends DanhMucState {}

class DanhMucLoaded extends DanhMucState {
  final List<DanhMuc> danhmucs;

  const DanhMucLoaded(this.danhmucs);

  @override
  List<Object> get props => [danhmucs];
}

class DanhMucError extends DanhMucState {
  final String message;

  const DanhMucError(this.message);

  @override
  List<Object> get props => [message];
}

class DanhMucOperationSuccess
    extends DanhMucState {} // Can be more specific if needed

class DanhMucOperationFailure extends DanhMucState {
  final String message;

  const DanhMucOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}
