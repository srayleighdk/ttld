part of 'tantat_bloc.dart';

abstract class TinhTrangTanTatEvent extends Equatable {
  const TinhTrangTanTatEvent();

  @override
  List<Object> get props => [];
}

class LoadTinhTrangTanTats extends TinhTrangTanTatEvent {}

class CreateTinhTrangTanTat extends TinhTrangTanTatEvent {
  final TinhTrangTanTat tinhTrangTanTat;

  const CreateTinhTrangTanTat(this.tinhTrangTanTat);

  @override
  List<Object> get props => [tinhTrangTanTat];
}

class UpdateTinhTrangTanTat extends TinhTrangTanTatEvent {
  final int id;
  final TinhTrangTanTat tinhTrangTanTat;

  const UpdateTinhTrangTanTat(this.id, this.tinhTrangTanTat);

  @override
  List<Object> get props => [id, tinhTrangTanTat];
}

class DeleteTinhTrangTanTat extends TinhTrangTanTatEvent {
  final int id;

  const DeleteTinhTrangTanTat(this.id);

  @override
  List<Object> get props => [id];
}
