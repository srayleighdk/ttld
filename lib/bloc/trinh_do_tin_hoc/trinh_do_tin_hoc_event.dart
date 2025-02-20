part of 'trinh_do_tin_hoc_bloc.dart';

sealed class TrinhDoTinHocEvent {}

class LoadTrinhDoTinHocs extends TrinhDoTinHocEvent {}

class AddTrinhDoTinHoc extends TrinhDoTinHocEvent {
  final TrinhDoTinHoc trinhDoTinHoc;

  AddTrinhDoTinHoc({required this.trinhDoTinHoc});
}

class UpdateTrinhDoTinHoc extends TrinhDoTinHocEvent {
  final TrinhDoTinHoc trinhDoTinHoc;

  UpdateTrinhDoTinHoc({required this.trinhDoTinHoc});
}

class DeleteTrinhDoTinHoc extends TrinhDoTinHocEvent {
  final String tdthId;

  DeleteTrinhDoTinHoc({required this.tdthId});
}
