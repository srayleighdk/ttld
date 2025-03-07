part of 'loai_hop_dong_lao_dong_bloc.dart';

abstract class LoaiHopDongLaoDongState extends Equatable {
  const LoaiHopDongLaoDongState();

  @override
  List<Object> get props => [];
}

class LoaiHopDongLaoDongInitial extends LoaiHopDongLaoDongState {}

class LoaiHopDongLaoDongLoading extends LoaiHopDongLaoDongState {}

class LoaiHopDongLaoDongLoaded extends LoaiHopDongLaoDongState {
  final List<LoaiHopDongLaoDong> loaiHopDongs;

  const LoaiHopDongLaoDongLoaded(this.loaiHopDongs);

  @override
  List<Object> get props => [loaiHopDongs];
}

class LoaiHopDongLaoDongError extends LoaiHopDongLaoDongState {
  final String message;

  const LoaiHopDongLaoDongError(this.message);

  @override
  List<Object> get props => [message];
}
