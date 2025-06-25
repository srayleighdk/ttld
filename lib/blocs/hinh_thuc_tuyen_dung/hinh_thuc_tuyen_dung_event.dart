part of 'hinh_thuc_tuyen_dung_bloc.dart';

abstract class HinhThucTuyenDungEvent extends Equatable {
  const HinhThucTuyenDungEvent();

  @override
  List<Object> get props => [];
}

class LoadHinhThucTuyenDung extends HinhThucTuyenDungEvent {}

class AddHinhThucTuyenDung extends HinhThucTuyenDungEvent {
  final HinhThucTuyenDung hinhThuc;

  const AddHinhThucTuyenDung(this.hinhThuc);

  @override
  List<Object> get props => [hinhThuc];
}

class UpdateHinhThucTuyenDung extends HinhThucTuyenDungEvent {
  final HinhThucTuyenDung hinhThuc;

  const UpdateHinhThucTuyenDung(this.hinhThuc);

  @override
  List<Object> get props => [hinhThuc];
}

class DeleteHinhThucTuyenDung extends HinhThucTuyenDungEvent {
  final String id;

  const DeleteHinhThucTuyenDung(this.id);

  @override
  List<Object> get props => [id];
}
