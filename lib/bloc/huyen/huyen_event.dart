import 'package:ttld/models/huyen/huyen.dart';

abstract class HuyenEvent {}

class LoadHuyens extends HuyenEvent {}

class AddHuyen extends HuyenEvent {
  final Huyen huyen;

  AddHuyen({required this.huyen});
}

class UpdateHuyen extends HuyenEvent {
  final Huyen huyen;

  UpdateHuyen({required this.huyen});
}

class DeleteHuyen extends HuyenEvent {
  final String id;

  DeleteHuyen({required this.id});
}
