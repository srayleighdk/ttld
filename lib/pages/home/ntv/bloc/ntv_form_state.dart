part of 'ntv_form_bloc.dart';

abstract class NTVFormState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends NTVFormState {}

class UserLoading extends NTVFormState {}

class UserSuccess extends NTVFormState {}

class UserFailure extends NTVFormState {}
