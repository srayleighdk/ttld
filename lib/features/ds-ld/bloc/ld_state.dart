part of 'ld_bloc.dart';

abstract class LdState {
  const LdState();
}

class LdInitial extends LdState {}

class LdLoading extends LdState {}

class LdLoaded extends LdState {
  final LdModel ld;
  final bool isNewLd;

  const LdLoaded({
    required this.ld,
    required this.isNewLd,
  });
}

class LdsLoaded extends LdState {
  final PaginatedResponse<LdModel> response;
  final int currentPage;
  final int pageSize;

  const LdsLoaded({
    required this.response,
    required this.currentPage,
    required this.pageSize,
  });

  bool get hasMore => response.hasMore(currentPage, pageSize);
  int get totalPages => response.getTotalPages(pageSize);
}

class LdSaved extends LdState {
  final LdModel ld;
  final String message;

  const LdSaved(this.ld, {required this.message});
}

class LdDeleted extends LdState {
  final String message;

  const LdDeleted({required this.message});
}

class LdError extends LdState {
  final String message;

  const LdError(this.message);
}
