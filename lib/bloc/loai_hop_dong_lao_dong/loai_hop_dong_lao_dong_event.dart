part of 'loai_hop_dong_lao_dong_bloc.dart';

abstract class LoaiHopDongLaoDongEvent extends Equatable {
  const LoaiHopDongLaoDongEvent();

  @override
  List<Object> get props => [];
}

class LoadLoaiHopDong extends LoaiHopDongLaoDongEvent {}

class AddLoaiHopDong extends LoaiHopDongLaoDongEvent {
  final LoaiHopDongLaoDong loaiHopDong;

  const AddLoaiHopDong(this.loaiHopDong);

  @override
  List<Object> get props => [loaiHopDong];
}

class UpdateLoaiHopDong extends LoaiHopDongLaoDongEvent {
  final LoaiHopDongLaoDong loaiHopDong;

  const UpdateLoaiHopDong(this.loaiHopDong);

  @override
  List<Object> get props => [loaiHopDong];
}

class DeleteLoaiHopDong extends LoaiHopDongLaoDongEvent {
  final String id;

  const DeleteLoaiHopDong(this.id);

  @override
  List<Object> get props => [id];
}
