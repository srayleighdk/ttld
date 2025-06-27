import 'package:equatable/equatable.dart';
import 'package:ttld/models/dn_dk_pgd/dn_dk_pgd_model.dart';

abstract class DnDkPgdState extends Equatable {
  const DnDkPgdState();

  @override
  List<Object?> get props => [];
}

class DnDkPgdInitial extends DnDkPgdState {}

class DnDkPgdLoading extends DnDkPgdState {}

class DnDkPgdListLoaded extends DnDkPgdState {
  final List<DnDkPgd> dnDkPgdList;

  const DnDkPgdListLoaded(this.dnDkPgdList);

  @override
  List<Object?> get props => [dnDkPgdList];
}

class DnDkPgdCreated extends DnDkPgdState {
  final DnDkPgd dnDkPgd;

  const DnDkPgdCreated(this.dnDkPgd);

  @override
  List<Object?> get props => [dnDkPgd];
}

class DnDkPgdUpdated extends DnDkPgdState {
  final DnDkPgd dnDkPgd;

  const DnDkPgdUpdated(this.dnDkPgd);

  @override
  List<Object?> get props => [dnDkPgd];
}

class DnDkPgdDeleted extends DnDkPgdState {
  final bool success;

  const DnDkPgdDeleted(this.success);

  @override
  List<Object?> get props => [success];
}

class DnDkPgdError extends DnDkPgdState {
  final String message;

  const DnDkPgdError(this.message);

  @override
  List<Object?> get props => [message];
}
