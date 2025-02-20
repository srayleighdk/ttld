part of 'ntd_bloc.dart';

abstract class NTDEvent extends Equatable {
  const NTDEvent();

  @override
  List<Object> get props => [];
}

class NTDFetchList extends NTDEvent {}

class NTDFetchById extends NTDEvent {
  final int id;

  const NTDFetchById(this.id);

  @override
  List<Object> get props => [id];
}

class NTDAdd extends NTDEvent {
  final NtdModel ntd;

  const NTDAdd(this.ntd);

  @override
  List<Object> get props => [ntd];
}

class NTDUpdate extends NTDEvent {
  final NtdModel ntd;

  const NTDUpdate(this.ntd);

  @override
  List<Object> get props => [ntd];
}

class NTDDelete extends NTDEvent {
  final int id;

  const NTDDelete(this.id);

  @override
  List<Object> get props => [id];
}
