part of 'muc_dich_lam_viec_bloc.dart';

abstract class MucDichLamViecEvent extends Equatable {
  const MucDichLamViecEvent();

  @override
  List<Object> get props => [];
}

class LoadMucDichLamViec extends MucDichLamViecEvent {}

class AddMucDichLamViec extends MucDichLamViecEvent {
  final MucDichLamViec mucDich;

  const AddMucDichLamViec(this.mucDich);

  @override
  List<Object> get props => [mucDich];
}

class UpdateMucDichLamViec extends MucDichLamViecEvent {
  final MucDichLamViec mucDich;

  const UpdateMucDichLamViec(this.mucDich);

  @override
  List<Object> get props => [mucDich];
}

class DeleteMucDichLamViec extends MucDichLamViecEvent {
  final String id;

  const DeleteMucDichLamViec(this.id);

  @override
  List<Object> get props => [id];
}
