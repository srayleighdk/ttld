part of 'do_tuoi_cubit.dart';

class DoTuoiState {}

class DoTuoiInitial extends DoTuoiState {}

class DoTuoiLoading extends DoTuoiState {}

class DoTuoiLoaded extends DoTuoiState {
  final List<DoTuoi> doTuois;
  DoTuoiLoaded(this.doTuois);
}

class DoTuoiError extends DoTuoiState {
  final String message;
  DoTuoiError(this.message);
}
