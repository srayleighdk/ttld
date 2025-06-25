part of 'chapnoi_bloc.dart';

@immutable
sealed class ChapNoiEvent {}

class ChapNoiFetchList extends ChapNoiEvent {
  final int limit;
  final int page;
  final int? status;
  final String? idTuyenDung;
  final String? idDoanhNghiep;
  final String? idUv;

  ChapNoiFetchList({
    required this.limit,
    required this.page,
    this.status,
    this.idTuyenDung,
    this.idDoanhNghiep,
    this.idUv,
  });
}

class ChapNoiCreate extends ChapNoiEvent {
  final ChapNoiModel chapNoi;

  ChapNoiCreate(this.chapNoi);
}

class ChapNoiDelete extends ChapNoiEvent {
  final String id;

  ChapNoiDelete(this.id);
}
