import 'package:ttld/models/xa/xa.dart';

abstract class XaEvent {}

class LoadXas extends XaEvent {}

class AddXa extends XaEvent {
  final Xa xa;

  AddXa({required this.xa});
}

class UpdateXa extends XaEvent {
  final Xa xa;

  UpdateXa({required this.xa});
}

class DeleteXa extends XaEvent {
  final String id;

  DeleteXa({required this.id});
}
