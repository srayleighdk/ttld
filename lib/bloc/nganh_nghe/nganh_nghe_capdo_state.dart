part of 'nganh_nghe_capdo_bloc.dart';

sealed class NganhNgheCapDoState {}

class NganhNgheCapDoInitial extends NganhNgheCapDoState {}

class NganhNgheCapDoLoading extends NganhNgheCapDoState {}

class NganhNgheCapDo2Loading extends NganhNgheCapDoState {}

class NganhNgheCapDo3Loading extends NganhNgheCapDoState {}

class NganhNgheCapDo4Loading extends NganhNgheCapDoState {}

class NganhNgheCapDoLoaded extends NganhNgheCapDoState {
  final List<NganhNgheCapDo> nganhNgheCapDos;

  NganhNgheCapDoLoaded({required this.nganhNgheCapDos});
}

class NganhNgheCapDo2Loaded extends NganhNgheCapDoState {
  final List<NganhNgheCapDo> nganhNgheCapDo2s;

  NganhNgheCapDo2Loaded({required this.nganhNgheCapDo2s});
}

class NganhNgheCapDo3Loaded extends NganhNgheCapDoState {
  final List<NganhNgheCapDo> nganhNgheCapDo3s;

  NganhNgheCapDo3Loaded({required this.nganhNgheCapDo3s});
}

class NganhNgheCapDo4Loaded extends NganhNgheCapDoState {
  final List<NganhNgheCapDo> nganhNgheCapDo4s;

  NganhNgheCapDo4Loaded({required this.nganhNgheCapDo4s});
}

class NganhNgheCapDoError extends NganhNgheCapDoState {
  final String message;

  NganhNgheCapDoError({required this.message});
}
