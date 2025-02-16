part of 'group_bloc.dart';

abstract class GroupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadGroups extends GroupEvent {}

class CreateGroup extends GroupEvent {
  final String name;
  final String? parentId;

  CreateGroup(this.name, {this.parentId});

  @override
  List<Object?> get props => [name, parentId];
}

class UpdateGroup extends GroupEvent {
  final String id;
  final String name;
  final String? description;

  UpdateGroup(this.id, this.name, {this.description});

  @override
  List<Object?> get props => [id, name, description];
}

class DeleteGroup extends GroupEvent {
  final String id;

  DeleteGroup(this.id);

  @override
  List<Object?> get props => [id];
}
