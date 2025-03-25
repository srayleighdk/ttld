part of 'tinhtrang_hd_cubit.dart';

@immutable
abstract class TinhTrangHdState {}

class TinhTrangHdInitial extends TinhTrangHdState {}

class TinhTrangHdLoading extends TinhTrangHdState {}

class TinhTrangHdLoaded extends TinhTrangHdState {
  final List<TinhTrangHdModel> items;
  TinhTrangHdLoaded(this.items);
}

class TinhTrangHdError extends TinhTrangHdState {
  final String message;
  TinhTrangHdError(this.message);
}
