part of 'doituong_bloc.dart';

abstract class DoiTuongChinhSachEvent extends Equatable {
  const DoiTuongChinhSachEvent();

  @override
  List<Object> get props => [];
}

class LoadDoiTuongChinhSachs extends DoiTuongChinhSachEvent {}

class CreateDoiTuongChinhSach extends DoiTuongChinhSachEvent {
  final DoiTuongChinhSach doiTuongChinhSach;

  const CreateDoiTuongChinhSach(this.doiTuongChinhSach);

  @override
  List<Object> get props => [doiTuongChinhSach];
}

class UpdateDoiTuongChinhSach extends DoiTuongChinhSachEvent {
  final int id;
  final DoiTuongChinhSach doiTuongChinhSach;

  const UpdateDoiTuongChinhSach(this.id, this.doiTuongChinhSach);

  @override
  List<Object> get props => [id, doiTuongChinhSach];
}

class DeleteDoiTuongChinhSach extends DoiTuongChinhSachEvent {
  final int id;

  const DeleteDoiTuongChinhSach(this.id);

  @override
  List<Object> get props => [id];
}
