part of 'chapnoi_bloc.dart';

@immutable
sealed class ChapNoiEvent {}

class ChapNoiFetchList extends ChapNoiEvent {
  final int limit;
  final int page;
  final int? status;
  final String? idTuyenDung;
  final String? idDoanhNghiep;

  ChapNoiFetchList({
    required this.limit,
    required this.page,
    this.status,
    this.idTuyenDung,
    this.idDoanhNghiep,
  });
}

class ChapNoiCreate extends ChapNoiEvent {
  final ChapNoiModel chapNoi;

  ChapNoiCreate(this.chapNoi);
}
