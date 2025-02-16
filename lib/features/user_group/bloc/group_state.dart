part of 'group_bloc.dart';

abstract class GroupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GroupLoading extends GroupState {}

class GroupLoaded extends GroupState {
  final List<Group> groups;

  GroupLoaded(this.groups);

  @override
  List<Object?> get props => [groups];
}

class GroupError extends GroupState {
  final String error;

  GroupError(this.error);

  @override
  List<Object?> get props => [error];
}
