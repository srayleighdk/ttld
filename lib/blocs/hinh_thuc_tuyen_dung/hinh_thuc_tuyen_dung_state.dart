part of 'hinh_thuc_tuyen_dung_bloc.dart';

abstract class HinhThucTuyenDungState extends Equatable {
  const HinhThucTuyenDungState();

  @override
  List<Object> get props => [];
}

class HinhThucTuyenDungInitial extends HinhThucTuyenDungState {}

class HinhThucTuyenDungLoading extends HinhThucTuyenDungState {}

class HinhThucTuyenDungLoaded extends HinhThucTuyenDungState {
  final List<HinhThucTuyenDung> hinhThucs;

  const HinhThucTuyenDungLoaded(this.hinhThucs);

  @override
  List<Object> get props => [hinhThucs];
}

class HinhThucTuyenDungError extends HinhThucTuyenDungState {
  final String message;

  const HinhThucTuyenDungError(this.message);

  @override
  List<Object> get props => [message];
}
