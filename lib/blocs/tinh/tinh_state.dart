import 'package:ttld/models/tinh/tinh.dart';

abstract class TinhState {}

class TinhInitial extends TinhState {}

class TinhLoading extends TinhState {}

class TinhLoaded extends TinhState {
  final List<Tinh> tinhs;

  TinhLoaded({required this.tinhs});
}

class TinhError extends TinhState {
  final String message;

  TinhError({required this.message});
}
