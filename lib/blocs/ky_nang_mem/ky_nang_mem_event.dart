part of 'ky_nang_mem_bloc.dart';

abstract class KyNangMemEvent extends Equatable {
  const KyNangMemEvent();

  @override
  List<Object> get props => [];
}

class LoadKyNangMems extends KyNangMemEvent {}

class AddKyNangMem extends KyNangMemEvent {
  final KyNangMemModel kyNangMem;

  const AddKyNangMem(this.kyNangMem);

  @override
  List<Object> get props => [kyNangMem];
}

class UpdateKyNangMem extends KyNangMemEvent {
  final KyNangMemModel kyNangMem;

  const UpdateKyNangMem(this.kyNangMem);

  @override
  List<Object> get props => [kyNangMem];
}

class DeleteKyNangMem extends KyNangMemEvent {
  final int id;

  const DeleteKyNangMem(this.id);

  @override
  List<Object> get props => [id];
}
