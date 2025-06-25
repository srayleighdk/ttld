part of 'muc_dich_lam_viec_bloc.dart';

abstract class MucDichLamViecState extends Equatable {
  const MucDichLamViecState();

  @override
  List<Object> get props => [];
}

class MucDichLamViecInitial extends MucDichLamViecState {}

class MucDichLamViecLoading extends MucDichLamViecState {}

class MucDichLamViecLoaded extends MucDichLamViecState {
  final List<MucDichLamViec> mucDichs;

  const MucDichLamViecLoaded(this.mucDichs);

  @override
  List<Object> get props => [mucDichs];
}

class MucDichLamViecError extends MucDichLamViecState {
  final String message;

  const MucDichLamViecError(this.message);

  @override
  List<Object> get props => [message];
}
