part of 'chinhsachluong_bloc.dart';

@immutable
sealed class ChinhSachLuongState {}

class ChinhSachLuongInitial extends ChinhSachLuongState {}

class ChinhSachLuongLoading extends ChinhSachLuongState {}

class ChinhSachLuongLoadSuccess extends ChinhSachLuongState {
  final List<ChinhSachLuong> cslList;
  ChinhSachLuongLoadSuccess(this.cslList);
}

class ChinhSachLuongCreateSuccess extends ChinhSachLuongState {
  final ChinhSachLuong csl;
  ChinhSachLuongCreateSuccess(this.csl);
}

class ChinhSachLuongUpdateSuccess extends ChinhSachLuongState {
  final ChinhSachLuong csl;
  ChinhSachLuongUpdateSuccess(this.csl);
}

class ChinhSachLuongDeleteSuccess extends ChinhSachLuongState {}

class ChinhSachLuongOperationFailure extends ChinhSachLuongState {
  final String error;
  ChinhSachLuongOperationFailure(this.error);
}

class ChinhSachLuongOperationSuccess extends ChinhSachLuongState {
  final String success;
  ChinhSachLuongOperationSuccess(this.success);
}
