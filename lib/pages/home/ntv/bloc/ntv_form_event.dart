part of 'ntv_form_bloc.dart';

abstract class NTVFormEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateUserEvent extends NTVFormEvent {
  final Ntv ntv;
  CreateUserEvent(this.ntv);
}

class UpdateUserEvent extends NTVFormEvent {
  final Ntv ntv;
  UpdateUserEvent(this.ntv);
}
