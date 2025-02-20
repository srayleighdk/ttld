part of 'nguon_vieclam_bloc.dart';

sealed class NguonViecLamState {}

class NguonViecLamInitial extends NguonViecLamState {}

class NguonViecLamLoading extends NguonViecLamState {}

class NguonViecLamLoaded extends NguonViecLamState {
  final List<NguonViecLam> nguonViecLams;

  NguonViecLamLoaded({required this.nguonViecLams});
}

class NguonViecLamError extends NguonViecLamState {
  final String message;

  NguonViecLamError({required this.message});
}
