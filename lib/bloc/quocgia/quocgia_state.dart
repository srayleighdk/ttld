part of 'quocgia_bloc.dart';

sealed class QuocGiaState {}

class QuocGiaInitial extends QuocGiaState {}

class QuocGiaLoading extends QuocGiaState {}

class QuocGiaLoaded extends QuocGiaState {
  final List<QuocGia> quocGias;

  QuocGiaLoaded({required this.quocGias});
}

class QuocGiaError extends QuocGiaState {
  final String message;

  QuocGiaError({required this.message});
}
