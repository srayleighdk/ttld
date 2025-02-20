part of 'trinh_do_hoc_van_bloc.dart';

sealed class TrinhDoHocVanEvent {}

class LoadTrinhDoHocVans extends TrinhDoHocVanEvent {}

class AddTrinhDoHocVan extends TrinhDoHocVanEvent {
  final TrinhDoHocVan trinhDoHocVan;

  AddTrinhDoHocVan({required this.trinhDoHocVan});
}

class UpdateTrinhDoHocVan extends TrinhDoHocVanEvent {
  final TrinhDoHocVan trinhDoHocVan;

  UpdateTrinhDoHocVan({required this.trinhDoHocVan});
}

class DeleteTrinhDoHocVan extends TrinhDoHocVanEvent {
  final String hocvanTen;

  DeleteTrinhDoHocVan({required this.hocvanTen});
}
