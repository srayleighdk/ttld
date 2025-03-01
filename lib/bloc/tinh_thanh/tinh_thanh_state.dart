part of 'tinh_thanh_cubit.dart';

abstract class TinhThanhState extends Equatable {
  const TinhThanhState();

  @override
  List<Object> get props => [];
}

class TinhThanhInitial extends TinhThanhState {}

class TinhThanhLoading extends TinhThanhState {}

class TinhThanhLoaded extends TinhThanhState {
  final List<TinhThanhModel> tinhThanhs;

  const TinhThanhLoaded({required this.tinhThanhs});

  @override
  List<Object> get props => [tinhThanhs];
}

class TinhThanhError extends TinhThanhState {
  final String message;

  const TinhThanhError({required this.message});

  @override
  List<Object> get props => [message];
}
