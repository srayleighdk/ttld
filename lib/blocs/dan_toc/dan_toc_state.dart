part of 'dan_toc_bloc.dart';

sealed class DanTocState {}

class DanTocInitial extends DanTocState {}

class DanTocLoading extends DanTocState {}

class DanTocLoaded extends DanTocState {
  final List<DanToc> danTocs;

  DanTocLoaded({required this.danTocs});
}

class DanTocError extends DanTocState {
  final String message;

  DanTocError({required this.message});
}
