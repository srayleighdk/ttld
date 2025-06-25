part of 'trinh_do_ngoai_ngu_bloc.dart';

sealed class TrinhDoNgoaiNguState {}

class TrinhDoNgoaiNguInitial extends TrinhDoNgoaiNguState {}

class TrinhDoNgoaiNguLoading extends TrinhDoNgoaiNguState {}

class TrinhDoNgoaiNguLoaded extends TrinhDoNgoaiNguState {
  final List<TrinhDoNgoaiNgu> trinhDoNgoaiNgus;

  TrinhDoNgoaiNguLoaded({required this.trinhDoNgoaiNgus});
}

class TrinhDoNgoaiNguError extends TrinhDoNgoaiNguState {
  final String message;

  TrinhDoNgoaiNguError({required this.message});
}
