part of 'trinh_do_van_hoa_bloc.dart';

sealed class TrinhDoVanHoaEvent {}

class LoadTrinhDoVanHoas extends TrinhDoVanHoaEvent {}

class AddTrinhDoVanHoa extends TrinhDoVanHoaEvent {
  final TrinhDoVanHoa trinhDoVanHoa;

  AddTrinhDoVanHoa({required this.trinhDoVanHoa});
}

class UpdateTrinhDoVanHoa extends TrinhDoVanHoaEvent {
  final TrinhDoVanHoa trinhDoVanHoa;

  UpdateTrinhDoVanHoa({required this.trinhDoVanHoa});
}

class DeleteTrinhDoVanHoa extends TrinhDoVanHoaEvent {
  final String hocvanTen;

  DeleteTrinhDoVanHoa({required this.hocvanTen});
}
