part of 'nganh_nghe_bloc.dart';

sealed class NganhNgheEvent {}

class LoadNganhNghes extends NganhNgheEvent {}

class AddNganhNghe extends NganhNgheEvent {
  final NganhNghe nganhNghe;

  AddNganhNghe({required this.nganhNghe});
}

class UpdateNganhNghe extends NganhNgheEvent {
  final NganhNghe nganhNghe;

  UpdateNganhNghe({required this.nganhNghe});
}

class DeleteNganhNghe extends NganhNgheEvent {
  final String idNkt;

  DeleteNganhNghe({required this.idNkt});
}
