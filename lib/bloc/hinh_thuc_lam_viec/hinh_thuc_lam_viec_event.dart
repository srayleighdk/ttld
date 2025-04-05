part of 'hinh_thuc_lam_viec_bloc.dart';

abstract class HinhThucLamViecEvent extends Equatable {
  const HinhThucLamViecEvent();

  @override
  List<Object> get props => [];
}

class LoadHinhThucLamViecs extends HinhThucLamViecEvent {}

class AddHinhThucLamViec extends HinhThucLamViecEvent {
  final HinhThucLamViecModel hinhThucLamViec;

  const AddHinhThucLamViec(this.hinhThucLamViec);

  @override
  List<Object> get props => [hinhThucLamViec];
}

class UpdateHinhThucLamViec extends HinhThucLamViecEvent {
  final HinhThucLamViecModel hinhThucLamViec;

  const UpdateHinhThucLamViec(this.hinhThucLamViec);

  @override
  List<Object> get props => [hinhThucLamViec];
}

class DeleteHinhThucLamViec extends HinhThucLamViecEvent {
  final int id;

  const DeleteHinhThucLamViec(this.id);

  @override
  List<Object> get props => [id];
}
