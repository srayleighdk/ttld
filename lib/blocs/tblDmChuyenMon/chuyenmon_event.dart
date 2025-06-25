part of 'chuyenmon_bloc.dart';

abstract class ChuyenMonEvent extends Equatable {
  const ChuyenMonEvent();

  @override
  List<Object> get props => [];
}

class LoadChuyenMons extends ChuyenMonEvent {}

class CreateChuyenMon extends ChuyenMonEvent {
  final ChuyenMon chuyenMon;

  const CreateChuyenMon(this.chuyenMon);

  @override
  List<Object> get props => [chuyenMon];
}

class UpdateChuyenMon extends ChuyenMonEvent {
  final int id;
  final ChuyenMon chuyenMon;

  const UpdateChuyenMon(this.id, this.chuyenMon);

  @override
  List<Object> get props => [id, chuyenMon];
}

class DeleteChuyenMon extends ChuyenMonEvent {
  final int id;

  const DeleteChuyenMon(this.id);

  @override
  List<Object> get props => [id];
}
