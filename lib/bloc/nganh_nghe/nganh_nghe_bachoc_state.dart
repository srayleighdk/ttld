part of 'nganh_nghe_bachoc_bloc.dart';

sealed class NganhNgheBacHocState {}

class NganhNgheBacHocInitial extends NganhNgheBacHocState {}

class NganhNgheBacHocLoading extends NganhNgheBacHocState {}

class NganhNgheBacHocLoaded extends NganhNgheBacHocState {
  final List<NganhNgheBacHoc> nganhNgheBacHocs;

  NganhNgheBacHocLoaded({required this.nganhNgheBacHocs});
}

class NganhNgheBacHocError extends NganhNgheBacHocState {
  final String message;

  NganhNgheBacHocError({required this.message});
}
