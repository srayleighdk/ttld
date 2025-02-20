part of 'don_vi_bloc.dart';

sealed class DonViState {}

class DonViInitial extends DonViState {}

class DonViLoading extends DonViState {}

class DonViLoaded extends DonViState {
  final List<DonVi> donVis;

  DonViLoaded({required this.donVis});
}

class DonViError extends DonViState {
  final String message;

  DonViError({required this.message});
}
