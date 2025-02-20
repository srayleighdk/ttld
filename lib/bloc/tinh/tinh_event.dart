import 'package:ttld/models/tinh/tinh.dart';

abstract class TinhEvent {}

class LoadTinhs extends TinhEvent {}

class AddTinh extends TinhEvent {
  final Tinh tinh;

  AddTinh({required this.tinh});
}

class UpdateTinh extends TinhEvent {
  final Tinh tinh;

  UpdateTinh({required this.tinh});
}

class DeleteTinh extends TinhEvent {
  final String id;

  DeleteTinh({required this.id});
}
