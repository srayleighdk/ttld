import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangePasswordRequested extends ChangePasswordEvent {
  final String oldPassword;
  final String newPassword;

  ChangePasswordRequested(this.oldPassword, this.newPassword);

  @override
  List<Object> get props => [oldPassword, newPassword];
}
