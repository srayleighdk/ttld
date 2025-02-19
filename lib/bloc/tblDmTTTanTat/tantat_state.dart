part of 'tantat_bloc.dart';

abstract class TinhTrangTanTatState extends Equatable {
  const TinhTrangTanTatState();

  @override
  List<Object> get props => [];
}

class TinhTrangTanTatInitial extends TinhTrangTanTatState {}

class TinhTrangTanTatLoading extends TinhTrangTanTatState {}

class TinhTrangTanTatLoaded extends TinhTrangTanTatState {
  final List<TinhTrangTanTat> tinhTrangTanTats;

  const TinhTrangTanTatLoaded(this.tinhTrangTanTats);

  @override
  List<Object> get props => [tinhTrangTanTats];
}

class TinhTrangTanTatError extends TinhTrangTanTatState {
  final String message;

  const TinhTrangTanTatError(this.message);

  @override
  List<Object> get props => [message];
}

class TinhTrangTanTatOperationSuccess extends TinhTrangTanTatState {}

class TinhTrangTanTatOperationFailure extends TinhTrangTanTatState {
  final String message;

  const TinhTrangTanTatOperationFailure(this.message);

  @override
  List<Object> get props => [message];
}
