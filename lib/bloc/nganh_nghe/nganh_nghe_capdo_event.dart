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

class DeleteNganhNgheCapDo extends NganhNgheCapDoEvent {
  final int groupId;

  DeleteNganhNgheCapDo({required this.groupId});
}
