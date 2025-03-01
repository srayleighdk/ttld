part of 'dan_toc_bloc.dart';

sealed class DanTocEvent {}

class LoadDanTocs extends DanTocEvent {}

class AddDanToc extends DanTocEvent {
  final DanToc danToc;

  AddDanToc({required this.danToc});
}

class UpdateDanToc extends DanTocEvent {
  final DanToc danToc;

  UpdateDanToc({required this.danToc});
}

class DeleteDanToc extends DanTocEvent {
  final String id;

  DeleteDanToc({required this.id});
}
