part of 'trinh_do_hoc_van_bloc.dart';

sealed class TrinhDoHocVanState {}

class TrinhDoHocVanInitial extends TrinhDoHocVanState {}

class TrinhDoHocVanLoading extends TrinhDoHocVanState {}

class TrinhDoHocVanLoaded extends TrinhDoHocVanState {
  final List<TrinhDoHocVan> trinhDoHocVans;

  TrinhDoHocVanLoaded({required this.trinhDoHocVans});
}

class TrinhDoHocVanError extends TrinhDoHocVanState {
  final String message;

  TrinhDoHocVanError({required this.message});
}
