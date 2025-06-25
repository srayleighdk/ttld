part of 'ton_giao_bloc.dart';

sealed class TonGiaoEvent {}

class LoadTonGiaos extends TonGiaoEvent {}

class AddTonGiao extends TonGiaoEvent {
  final TonGiao tonGiao;

  AddTonGiao({required this.tonGiao});
}

class UpdateTonGiao extends TonGiaoEvent {
  final TonGiao tonGiao;

  UpdateTonGiao({required this.tonGiao});
}

class DeleteTonGiao extends TonGiaoEvent {
  final String tenTg;

  DeleteTonGiao({required this.tenTg});
}
