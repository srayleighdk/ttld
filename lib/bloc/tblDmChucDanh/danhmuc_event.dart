part of 'danhmuc_bloc.dart';

abstract class DanhMucEvent extends Equatable {
  const DanhMucEvent();

  @override
  List<Object> get props => [];
}

class LoadDanhMucs extends DanhMucEvent {}

class CreateDanhMuc extends DanhMucEvent {
  final DanhMuc danhmuc;

  const CreateDanhMuc(this.danhmuc);

  @override
  List<Object> get props => [danhmuc];
}

class UpdateDanhMuc extends DanhMucEvent {
  final int id;
  final DanhMuc danhmuc;

  const UpdateDanhMuc(this.id, this.danhmuc);

  @override
  List<Object> get props => [id, danhmuc];
}

class DeleteDanhMuc extends DanhMucEvent {
  final int id;

  const DeleteDanhMuc(this.id);

  @override
  List<Object> get props => [id];
}
