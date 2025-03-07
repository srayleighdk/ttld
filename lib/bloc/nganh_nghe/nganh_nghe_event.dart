part of 'nganh_nghe_bloc.dart';

sealed class NganhNgheEvent {}

class LoadNganhNghes extends NganhNgheEvent {}

class AddNganhNghe extends NganhNgheEvent {
  final NganhNgheKT nganhNghe;

  AddNganhNghe({required this.nganhNghe});
}

class UpdateNganhNghe extends NganhNgheEvent {
  final NganhNgheKT nganhNghe;

  UpdateNganhNghe({required this.nganhNghe});
}

class DeleteNganhNghe extends NganhNgheEvent {
  final String id;

  DeleteNganhNghe({required this.id});
}
