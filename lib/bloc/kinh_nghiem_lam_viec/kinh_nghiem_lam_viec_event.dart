part of 'kinh_nghiem_lam_viec_bloc.dart';

abstract class KinhNghiemLamViecEvent extends Equatable {
  const KinhNghiemLamViecEvent();

  @override
  List<Object> get props => [];
}

class LoadKinhNghiem extends KinhNghiemLamViecEvent {}

class AddKinhNghiem extends KinhNghiemLamViecEvent {
  final KinhNghiemLamViec kinhNghiem;

  const AddKinhNghiem(this.kinhNghiem);

  @override
  List<Object> get props => [kinhNghiem];
}

class UpdateKinhNghiem extends KinhNghiemLamViecEvent {
  final KinhNghiemLamViec kinhNghiem;

  const UpdateKinhNghiem(this.kinhNghiem);

  @override
  List<Object> get props => [kinhNghiem];
}

class DeleteKinhNghiem extends KinhNghiemLamViecEvent {
  final String id;

  const DeleteKinhNghiem(this.id);

  @override
  List<Object> get props => [id];
}
