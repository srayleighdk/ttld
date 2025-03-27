part of 'm01apli_bloc.dart';

@immutable
sealed class M01APliEvent {}

class LoadM01APlis extends M01APliEvent {}

class CreateM01APli extends M01APliEvent {
  final M01APli pli;
  CreateM01APli(this.pli);
}

class UpdateM01APli extends M01APliEvent {
  final M01APli pli;
  UpdateM01APli(this.pli);
}

class DeleteM01APli extends M01APliEvent {
  final String idphieu;
  DeleteM01APli(this.idphieu);
}
