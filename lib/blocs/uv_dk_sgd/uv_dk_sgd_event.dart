part of 'uv_dk_sgd_bloc.dart';

abstract class UvDkSGDEvent {}

class FetchUvDkSGDs extends UvDkSGDEvent {
  final String userId;
  FetchUvDkSGDs({required this.userId});
}

class RegisterForSGDVL extends UvDkSGDEvent {
  final UvDkSGD registration;
  RegisterForSGDVL({required this.registration});
}
