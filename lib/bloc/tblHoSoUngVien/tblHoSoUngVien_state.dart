import 'package:equatable/equatable.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';

abstract class NTVState extends Equatable {
  const NTVState();

  @override
  List<Object> get props => [];
}

class NTVInitial extends NTVState {}

class NTVLoading extends NTVState {}

class NTVLoaded extends NTVState {
  final List<TblHoSoUngVienModel> tblHoSoUngViens;

  const NTVLoaded(this.tblHoSoUngViens);

  @override
  List<Object> get props => [tblHoSoUngViens];
}

class NTVLoadedById extends NTVState {
  final TblHoSoUngVienModel? tblHoSoUngVien;

  const NTVLoadedById(this.tblHoSoUngVien);

  @override
  List<Object> get props => [tblHoSoUngVien!];
}

class NTVError extends NTVState {
  final String message;

  const NTVError(this.message);

  @override
  List<Object> get props => [message];
}
