part of 'kinh_nghiem_lam_viec_bloc.dart';

abstract class KinhNghiemLamViecState extends Equatable {
  const KinhNghiemLamViecState();

  @override
  List<Object> get props => [];
}

class KinhNghiemLamViecInitial extends KinhNghiemLamViecState {}

class KinhNghiemLamViecLoading extends KinhNghiemLamViecState {}

class KinhNghiemLamViecLoaded extends KinhNghiemLamViecState {
  final List<KinhNghiemLamViec> kinhNghiemList;

  const KinhNghiemLamViecLoaded(this.kinhNghiemList);

  @override
  List<Object> get props => [kinhNghiemList];
}

class KinhNghiemLamViecError extends KinhNghiemLamViecState {
  final String message;

  const KinhNghiemLamViecError(this.message);

  @override
  List<Object> get props => [message];
}

class KinhNghiemLamViecDeleted extends KinhNghiemLamViecState {}
