part of 'nganh_nghe_bloc.dart';

sealed class NganhNgheState {}

class NganhNgheInitial extends NganhNgheState {}

class NganhNgheLoading extends NganhNgheState {}

class NganhNgheLoaded extends NganhNgheState {
  final List<NganhNgheKT> nganhNghes;

  NganhNgheLoaded({required this.nganhNghes});
}

class NganhNgheError extends NganhNgheState {
  final String message;

  NganhNgheError({required this.message});
}
