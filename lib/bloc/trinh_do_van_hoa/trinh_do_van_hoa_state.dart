part of 'trinh_do_van_hoa_bloc.dart';

sealed class TrinhDoVanHoaState {}

class TrinhDoVanHoaInitial extends TrinhDoVanHoaState {}

class TrinhDoVanHoaLoading extends TrinhDoVanHoaState {}

class TrinhDoVanHoaLoaded extends TrinhDoVanHoaState {
  final List<TrinhDoVanHoa> trinhDoVanHoas;

  TrinhDoVanHoaLoaded({required this.trinhDoVanHoas});
}

class TrinhDoVanHoaError extends TrinhDoVanHoaState {
  final String message;

  TrinhDoVanHoaError({required this.message});
}
