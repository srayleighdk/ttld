import 'package:ttld/models/m03pli_model.dart';

abstract class M03PLIEvent {}

class LoadM03PLIs extends M03PLIEvent {}

class CreateM03PLI extends M03PLIEvent {
  final M03PLIModel m03pli;

  CreateM03PLI(this.m03pli);
}

class UpdateM03PLI extends M03PLIEvent {
  final M03PLIModel m03pli;

  UpdateM03PLI(this.m03pli);
}

class DeleteM03PLI extends M03PLIEvent {
  final String id;

  DeleteM03PLI(this.id);
}
