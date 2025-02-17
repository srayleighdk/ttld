import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ForgotPasswordRequested extends ForgotPasswordEvent {
  final String email;
  ForgotPasswordRequested(this.email);

  @override
  List<Object> get props => [email];
}
