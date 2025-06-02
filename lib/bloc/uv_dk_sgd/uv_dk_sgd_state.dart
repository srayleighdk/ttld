part of 'uv_dk_sgd_bloc.dart';

abstract class UvDkSGDState {}

class UvDkSGDInitial extends UvDkSGDState {}

class UvDkSGDLoading extends UvDkSGDState {}

class UvDkSGDLoaded extends UvDkSGDState {
  final List<UvDkSGD> uvDkSGDs;

  UvDkSGDLoaded(this.uvDkSGDs);
}

class UvDkSGDError extends UvDkSGDState {
  final String message;

  UvDkSGDError(this.message);
} 