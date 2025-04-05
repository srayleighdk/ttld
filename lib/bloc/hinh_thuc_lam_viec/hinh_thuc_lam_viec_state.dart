part of 'hinh_thuc_lam_viec_bloc.dart';

abstract class HinhThucLamViecState extends Equatable {
  const HinhThucLamViecState();

  @override
  List<Object> get props => [];
}

class HinhThucLamViecInitial extends HinhThucLamViecState {}

class HinhThucLamViecLoading extends HinhThucLamViecState {}

class HinhThucLamViecLoaded extends HinhThucLamViecState {
  final List<HinhThucLamViecModel> hinhThucLamViecs;

  const HinhThucLamViecLoaded(this.hinhThucLamViecs);

  @override
  List<Object> get props => [hinhThucLamViecs];
}

class HinhThucLamViecOperationSuccess extends HinhThucLamViecState {} // For Add/Update/Delete success feedback

class HinhThucLamViecError extends HinhThucLamViecState {
  final String message;

  const HinhThucLamViecError(this.message);

  @override
  List<Object> get props => [message];
}
