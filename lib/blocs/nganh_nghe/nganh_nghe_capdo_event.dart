part of 'nganh_nghe_capdo_bloc.dart';

sealed class NganhNgheCapDoEvent {}

class LoadNganhNgheCapDos extends NganhNgheCapDoEvent {}

class AddNganhNgheCapDo extends NganhNgheCapDoEvent {
  final NganhNgheCapDo nganhNgheCapDo;

  AddNganhNgheCapDo({required this.nganhNgheCapDo});
}

class UpdateNganhNgheCapDo extends NganhNgheCapDoEvent {
  final NganhNgheCapDo nganhNgheCapDo;

  UpdateNganhNgheCapDo({required this.nganhNgheCapDo});
}

class LoadNganhNgheCapDo2s extends NganhNgheCapDoEvent {
  final int id;
  final int level;

  LoadNganhNgheCapDo2s({required this.id, required this.level});
}

class LoadNganhNgheCapDo3s extends NganhNgheCapDoEvent {
  final int id;
  final int level;

  LoadNganhNgheCapDo3s({required this.id, required this.level});
}

class LoadNganhNgheCapDo4s extends NganhNgheCapDoEvent {
  final int id;
  final int level;

  LoadNganhNgheCapDo4s({required this.id, required this.level});
}

class DeleteNganhNgheCapDo extends NganhNgheCapDoEvent {
  final int groupId;

  DeleteNganhNgheCapDo({required this.groupId});
}
