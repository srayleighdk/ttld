part of 'nguon_vieclam_bloc.dart';

sealed class NguonViecLamEvent {}

class LoadNguonViecLams extends NguonViecLamEvent {}

class AddNguonViecLam extends NguonViecLamEvent {
  final NguonViecLam nguonViecLam;

  AddNguonViecLam({required this.nguonViecLam});
}

class UpdateNguonViecLam extends NguonViecLamEvent {
  final NguonViecLam nguonViecLam;

  UpdateNguonViecLam({required this.nguonViecLam});
}

class DeleteNguonViecLam extends NguonViecLamEvent {
  final int maNguonVlt;

  DeleteNguonViecLam({required this.maNguonVlt});
}
