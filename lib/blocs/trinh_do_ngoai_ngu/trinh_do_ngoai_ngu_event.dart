part of 'trinh_do_ngoai_ngu_bloc.dart';

sealed class TrinhDoNgoaiNguEvent {}

class LoadTrinhDoNgoaiNgus extends TrinhDoNgoaiNguEvent {}

class AddTrinhDoNgoaiNgu extends TrinhDoNgoaiNguEvent {
  final TrinhDoNgoaiNgu trinhDoNgoaiNgu;

  AddTrinhDoNgoaiNgu({required this.trinhDoNgoaiNgu});
}

class UpdateTrinhDoNgoaiNgu extends TrinhDoNgoaiNguEvent {
  final TrinhDoNgoaiNgu trinhDoNgoaiNgu;

  UpdateTrinhDoNgoaiNgu({required this.trinhDoNgoaiNgu});
}

class DeleteTrinhDoNgoaiNgu extends TrinhDoNgoaiNguEvent {
  final String id;

  DeleteTrinhDoNgoaiNgu({required this.id});
}
