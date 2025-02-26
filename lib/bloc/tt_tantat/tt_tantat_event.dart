part of 'tt_tantat_bloc.dart';

abstract class TTTanTatEvent extends Equatable {
  const TTTanTatEvent();

  @override
  List<Object> get props => [];
}

class LoadTTTanTats extends TTTanTatEvent {}

class AddTTTanTat extends TTTanTatEvent {
  final TTTanTat ttTanTat;

  const AddTTTanTat({required this.ttTanTat});

  @override
  List<Object> get props => [ttTanTat];
}

class UpdateTTTanTat extends TTTanTatEvent {
  final TTTanTat ttTanTat;

  const UpdateTTTanTat({required this.ttTanTat});

  @override
  List<Object> get props => [ttTanTat];
}

class DeleteTTTanTat extends TTTanTatEvent {
  final String id;

  const DeleteTTTanTat({required this.id});

  @override
  List<Object> get props => [id];
}
