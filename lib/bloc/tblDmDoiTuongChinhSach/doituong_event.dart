part of 'doituong_bloc.dart';

abstract class DoiTuongEvent extends Equatable {
  const DoiTuongEvent();

  @override
  List<Object> get props => [];
}

class LoadDoiTuongs extends DoiTuongEvent {}

class CreateDoiTuong extends DoiTuongEvent {
  final DoiTuong doiTuong;

  const CreateDoiTuong(this.doiTuong);

  @override
  List<Object> get props => [doiTuong];
}

class UpdateDoiTuong extends DoiTuongEvent {
  final int id;
  final DoiTuong doiTuong;

  const UpdateDoiTuong(this.id, this.doiTuong);

  @override
  List<Object> get props => [id, doiTuong];
}

class DeleteDoiTuong extends DoiTuongEvent {
  final int id;

  const DeleteDoiTuong(this.id);

  @override
  List<Object> get props => [id];
}
