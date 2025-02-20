part of 'nganh_nghe_td_bloc.dart';

sealed class NganhNgheTDState {}

class NganhNgheTDInitial extends NganhNgheTDState {}

class NganhNgheTDLoading extends NganhNgheTDState {}

class NganhNgheTDLoaded extends NganhNgheTDState {
  final List<NganhNgheTD> nganhNgheTDs;

  NganhNgheTDLoaded({required this.nganhNgheTDs});
}

class NganhNgheTDError extends NganhNgheTDState {
  final String message;

  NganhNgheTDError({required this.message});
}
