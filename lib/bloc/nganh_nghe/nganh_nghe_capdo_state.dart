part of 'nganh_nghe_capdo_bloc.dart';

sealed class NganhNgheCapDoState {}

class NganhNgheCapDoInitial extends NganhNgheCapDoState {}

class NganhNgheCapDoLoading extends NganhNgheCapDoState {}

class NganhNgheCapDoLoaded extends NganhNgheCapDoState {
  final List<NganhNgheCapDo> nganhNgheCapDos;

  NganhNgheCapDoLoaded({required this.nganhNgheCapDos});
}

class NganhNgheCapDoError extends NganhNgheCapDoState {
  final String message;

  NganhNgheCapDoError({required this.message});
}
