import 'package:equatable/equatable.dart';
import 'package:ttld/models/dn_dk_pgd/dn_dk_pgd_model.dart';

abstract class DnDkPgdEvent extends Equatable {
  const DnDkPgdEvent();

  @override
  List<Object?> get props => [];
}

class GetDnDkPgdList extends DnDkPgdEvent {
  const GetDnDkPgdList();
}

class CreateDnDkPgd extends DnDkPgdEvent {
  final DnDkPgd dnDkPgd;

  const CreateDnDkPgd(this.dnDkPgd);

  @override
  List<Object?> get props => [dnDkPgd];
}

class UpdateDnDkPgd extends DnDkPgdEvent {
  final DnDkPgd dnDkPgd;

  const UpdateDnDkPgd(this.dnDkPgd);

  @override
  List<Object?> get props => [dnDkPgd];
}

class DeleteDnDkPgd extends DnDkPgdEvent {
  final String id;

  const DeleteDnDkPgd(this.id);

  @override
  List<Object?> get props => [id];
}
