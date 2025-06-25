part of 'quocgia_bloc.dart';

sealed class QuocGiaEvent {}

class LoadQuocGias extends QuocGiaEvent {}

class AddQuocGia extends QuocGiaEvent {
  final QuocGia quocGia;

  AddQuocGia({required this.quocGia});
}

class UpdateQuocGia extends QuocGiaEvent {
  final QuocGia quocGia;

  UpdateQuocGia({required this.quocGia});
}

class DeleteQuocGia extends QuocGiaEvent {
  final String tenQuocGia;

  DeleteQuocGia({required this.tenQuocGia});
}
