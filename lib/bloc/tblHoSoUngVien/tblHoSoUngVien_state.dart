import 'package:equatable/equatable.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';

abstract class TblHoSoUngVienState extends Equatable {
  const TblHoSoUngVienState();

  @override
  List<Object> get props => [];
}

class TblHoSoUngVienInitial extends TblHoSoUngVienState {}

class TblHoSoUngVienLoading extends TblHoSoUngVienState {}

class TblHoSoUngVienLoaded extends TblHoSoUngVienState {
  final List<TblHoSoUngVienModel> tblHoSoUngViens;

  const TblHoSoUngVienLoaded(this.tblHoSoUngViens);

  @override
  List<Object> get props => [tblHoSoUngViens];
}

class TblHoSoUngVienLoadedById extends TblHoSoUngVienState {
  final TblHoSoUngVienModel? tblHoSoUngVien;

  const TblHoSoUngVienLoadedById(this.tblHoSoUngVien);

  @override
  List<Object> get props => [tblHoSoUngVien!];
}

class TblHoSoUngVienError extends TblHoSoUngVienState {
  final String message;

  const TblHoSoUngVienError(this.message);

  @override
  List<Object> get props => [message];
}
