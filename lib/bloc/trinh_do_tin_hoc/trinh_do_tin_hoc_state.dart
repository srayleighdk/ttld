part of 'trinh_do_tin_hoc_bloc.dart';

sealed class TrinhDoTinHocState {}

class TrinhDoTinHocInitial extends TrinhDoTinHocState {}

class TrinhDoTinHocLoading extends TrinhDoTinHocState {}

class TrinhDoTinHocLoaded extends TrinhDoTinHocState {
  final List<TrinhDoTinHoc> trinhDoTinHocs;

  TrinhDoTinHocLoaded({required this.trinhDoTinHocs});
}

class TrinhDoTinHocError extends TrinhDoTinHocState {
  final String message;

  TrinhDoTinHocError({required this.message});
}
