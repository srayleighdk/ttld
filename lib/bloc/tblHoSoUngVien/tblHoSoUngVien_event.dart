import 'package:equatable/equatable.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';

abstract class TblHoSoUngVienEvent extends Equatable {
  const TblHoSoUngVienEvent();

  @override
  List<Object> get props => [];
}

class LoadTblHoSoUngViens extends TblHoSoUngVienEvent {}

class LoadTblHoSoUngVien extends TblHoSoUngVienEvent {
  final String id;
  const LoadTblHoSoUngVien(this.id);
  @override
  List<Object> get props => [id];
}

class AddTblHoSoUngVien extends TblHoSoUngVienEvent {
  final TblHoSoUngVienModel tblHoSoUngVien;

  const AddTblHoSoUngVien(this.tblHoSoUngVien);

  @override
  List<Object> get props => [tblHoSoUngVien];
}

class UpdateTblHoSoUngVien extends TblHoSoUngVienEvent {
  final TblHoSoUngVienModel tblHoSoUngVien;

  const UpdateTblHoSoUngVien(this.tblHoSoUngVien);

  @override
  List<Object> get props => [tblHoSoUngVien];
}

class DeleteTblHoSoUngVien extends TblHoSoUngVienEvent {
  final int id;

  const DeleteTblHoSoUngVien(this.id);

  @override
  List<Object> get props => [id];
}
