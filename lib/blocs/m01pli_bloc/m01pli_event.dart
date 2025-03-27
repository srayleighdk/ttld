part of 'm01pli_bloc.dart';

@immutable
sealed class M01PliEvent {}

class LoadM01Plis extends M01PliEvent {}

class CreateM01Pli extends M01PliEvent {
  final M01Pli pli;
  CreateM01Pli(this.pli);
}

class UpdateM01Pli extends M01PliEvent {
  final M01Pli pli;
  UpdateM01Pli(this.pli);
}

class DeleteM01Pli extends M01PliEvent {
  final String idphieu;
  DeleteM01Pli(this.idphieu);
}
