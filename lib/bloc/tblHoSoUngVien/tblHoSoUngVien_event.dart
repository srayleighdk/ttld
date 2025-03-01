import 'package:equatable/equatable.dart';
import 'package:ttld/models/tblHoSoUngVien/tblHoSoUngVien_model.dart';

abstract class NTVEvent extends Equatable {
  const NTVEvent();

  @override
  List<Object> get props => [];
}

class LoadTblHoSoUngViens extends NTVEvent {}

class LoadTblHoSoUngVien extends NTVEvent {
  final int id;
  const LoadTblHoSoUngVien(this.id);
  @override
  List<Object> get props => [id];
}

class AddTblHoSoUngVien extends NTVEvent {
  final TblHoSoUngVienModel tblHoSoUngVien;

  const AddTblHoSoUngVien(this.tblHoSoUngVien);

  @override
  List<Object> get props => [tblHoSoUngVien];
}

class UpdateTblHoSoUngVien extends NTVEvent {
  final TblHoSoUngVienModel tblHoSoUngVien;

  const UpdateTblHoSoUngVien(this.tblHoSoUngVien);

  @override
  List<Object> get props => [tblHoSoUngVien];
}

class DeleteTblHoSoUngVien extends NTVEvent {
  final int id;

  const DeleteTblHoSoUngVien(this.id);

  @override
  List<Object> get props => [id];
}
