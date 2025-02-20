part of 'nguon_thuthap_bloc.dart';

sealed class NguonThuThapState {}

class NguonThuThapInitial extends NguonThuThapState {}

class NguonThuThapLoading extends NguonThuThapState {}

class NguonThuThapLoaded extends NguonThuThapState {
  final List<NguonThuThap> nguonThuThaps;

  NguonThuThapLoaded({required this.nguonThuThaps});
}

class NguonThuThapError extends NguonThuThapState {
  final String message;

  NguonThuThapError({required this.message});
}
