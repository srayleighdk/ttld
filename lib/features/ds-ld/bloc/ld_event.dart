part of 'ld_bloc.dart';

abstract class LdEvent {}

class InitializeNewLd extends LdEvent {}

class LoadLd extends LdEvent {
  final String? id;
  LoadLd({this.id});
}

class LoadLds extends LdEvent {
  final int page;
  final int limit;
  final Map<String, dynamic>? filters;

  LoadLds({
    this.page = 1,
    this.limit = 10,
    this.filters,
  });
}

class SaveLd extends LdEvent {
  final LdModel ld;
  final bool isNewLd;

  SaveLd({
    required this.ld,
    required this.isNewLd,
  });
}

class UpdateLd extends LdEvent {
  final LdModel ld;

  UpdateLd({required this.ld});
}

class DeleteLd extends LdEvent {
  final String id;

  DeleteLd({required this.id});
}
