import 'package:ttld/models/huyen/huyen.dart';

abstract class HuyenState {}

class HuyenInitial extends HuyenState {}

class HuyenLoading extends HuyenState {}

class HuyenLoadedByTinh extends HuyenState {
  final List<Huyen> huyens;

  HuyenLoadedByTinh({required this.huyens});
}

class HuyenLoaded extends HuyenState {
  final List<Huyen> huyens;

  HuyenLoaded({required this.huyens});
}

class HuyenError extends HuyenState {
  @override
  final String message;

  HuyenError({required this.message});
}
