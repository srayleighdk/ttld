part of 'ntd_bloc.dart';

abstract class NTDEvent extends Equatable {
  const NTDEvent();

  @override
  List<Object> get props => [];
}

class NTDFetchList extends NTDEvent {
  final int? limit;
  final int? page;
  final int? ntdLoai;
  final int? idStatus;
  final String? search;
  final int? idUv;

  const NTDFetchList({
    this.limit,
    this.page,
    this.ntdLoai,
    this.idStatus,
    this.search,
    this.idUv,
  });
}

class NTDFetchById extends NTDEvent {
  final int id;

  const NTDFetchById(this.id);

  @override
  List<Object> get props => [id];
}

class NTDAdd extends NTDEvent {
  final Ntd ntd;

  const NTDAdd(this.ntd);

  @override
  List<Object> get props => [ntd];
}

class NTDUpdate extends NTDEvent {
  final Ntd ntd;

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
