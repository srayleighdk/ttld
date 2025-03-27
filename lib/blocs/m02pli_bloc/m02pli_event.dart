part of 'm02pli_bloc.dart';

@immutable
sealed class M02PliEvent {}

class LoadM02Plis extends M02PliEvent {}

class CreateM02Pli extends M02PliEvent {
  final M02Pli pli;
  CreateM02Pli(this.pli);
}

class UpdateM02Pli extends M02PliEvent {
  final M02Pli pli;
  UpdateM02Pli(this.pli);
}

class DeleteM02Pli extends M02PliEvent {
  final String idphieu;
  DeleteM02Pli(this.idphieu);
}
